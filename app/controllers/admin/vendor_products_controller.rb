class Admin::VendorProductsController < Admin::BaseController

  before_action :set_vendor, only: [:index, :new, :verifying,:preview]
  before_action :set_vendor_product, only: [:instock, :out_of_stock, :locked, :unlocked, :sku]
  skip_before_action :verify_authenticity_token, only: :create

  def index
    @vendor_products = @vendor.vendor_products.normal.order(id: :desc).page(params[:page]).per(20)
  end

  def verifying
    @vendor_products = @vendor.vendor_products.hot.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @vendor_product = VendorProduct.new(vendor_id: params[:vendor_id].to_i)
  end

  def preview
    book = Roo::Spreadsheet.open vendor_product_params[:path]
    sheet = book.sheet 0
    head = ["CAS No.", "Product Name", "Assay/Purity", "In Stock (yes/no)", "Note"]
    data = []
    @result = {success: false}
    if sheet.row(1) == head
      sheet.each_with_index do |row, index|
        next if index < 1 || (row[0].blank? && row[1].blank?)
        if row[2].to_f.to_s == row[2].to_s.strip
          spec = "#{(row[2].to_f * 100).to_i}%"
        else
          spec = row[2].to_s.strip
        end
        r = VendorProduct.upload(@vendor, row[0], row[1], spec, row[3], row[4], current_employee, true)
        data << {cas: row[0].to_s, name: row[1].to_s, spec_info: spec, instock: row[3].to_s, note: row[4].to_s, result: r}
      end
      data = data.uniq
      success_count = data.select{|x| x[:result] == 'success' || x[:result] == 'verification' }.uniq{|x| "#{x[:name].to_s.strip}"}.length
      @result.merge!(success: true, data: data.uniq)
    else
      @result[:msg] = 'The file uploaded can not be recognized, please make sure you are using the template provided.'
    end
  end

  # 下载sku 反馈信息
  def download_feedback
    result = CGI.unescape(params[:item]) 
    data = JSON.parse(result)
    file = Spreadsheet::Workbook.new
      list = file.create_worksheet :name => "product_preverification_feedback"
      list.row(0).concat ["CAS No.", "Product Name",  "Assay/Purity",  "In Stock (yes/no)", "Note", "Result"]
      data.each_with_index { |report, i|
        list.row(i+1).concat report.values
      }
      xls_report = StringIO.new 
      file.write xls_report 
      send_data xls_report.string, :type => 'text/xls', :filename => "product_preverification_feedback.xls"
  end

  def create
    contact = Contact.find params[:contact_id]
    result = {result: false}
    if params[:data].present?
      result.merge!(result: true, vendor_id: contact.vendor_id)
      params[:data].each do |index, data|
        VendorProduct.upload(contact, data[:cas], data[:name], data[:spec_info], data[:instock], data[:note], current_employee)
      end
    end
    render json: result
  end

  def instock
    @vendor_product.update(instock: :instock)
  end

  def out_of_stock
    @vendor_product.update(instock: :out_of_stock)
    render :instock
  end

  def locked
    @vendor_product.update(locked: true)
    render :instock
  end

  def unlocked
    @vendor_product.update(locked: false)
    render :instock
  end

  def sku
    @q = SearchParams.new(params[:search_params] || {})
    @skus = @vendor_product.vendor_product_specs.actived.default_where(@q.attributes(self)).order(:spec_info).page(params[:page]).per(20)
  end

  def instock_sku
    @sku = VendorProductSpec.find params[:id]
    @sku.update(instock: :instock)
  end

  def out_of_stock_sku
    @sku = VendorProductSpec.find params[:id]
    @sku.update(instock: :out_of_stock)
    render :instock_sku
  end

  private 

  def set_vendor
    @vendor = Vendor.find params[:vendor_id]||params[:vendor_product][:vendor_id]
  end

  def set_vendor_product
     @vendor_product = VendorProduct.find params[:id]
  end

  def vendor_product_params
    params.require(:vendor_product).permit(:vendor_id, :path)
  end

  # def search_filter_cas(v)
  #   return nil if v.blank?
  #   v = v.to_s.strip
  #   chemical = Chemical.find_by(cas: v)
  #   chemical = chemical || Chemical.find_by(id: v.gsub(/[^0-9]/,''))
  #   return lambda{|scope| scope.where('1=0')} if chemical.blank?
  #   return lambda{|scope| scope.where(chemical_id: chemical.id)}
  # end

  # def search_filter_product_name(v)
  #   return nil if v.blank?
  #   chemical = Chemical.find_by(name: v.to_s.strip)
  #   return lambda{|scope| scope.where('1=0')} if chemical.blank?
  #   return lambda{|scope| scope.where(chemical_id: chemical.id)}
  # end

  def handle_unverified_request
   # form表单不验证
  end

end

