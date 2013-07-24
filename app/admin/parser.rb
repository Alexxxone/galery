ActiveAdmin.register_page "Parser" do
  require 'uri'

  page_action :create_picture, :method => :post do
    curl =  Curl.get(params[:file_addr])
    tempfile=Tempfile.new(Time.now.to_f.to_s)
    tempfile.write curl.body_str.force_encoding('utf-8')
    uploaded_file = ActionDispatch::Http::UploadedFile.new(:tempfile => tempfile, :filename => params[:file_addr].split("/").last)
    @pic = Picture.create!(:title=>params[:file_addr],:filename=>uploaded_file)
    @pic.categories = Category.where(:name => params[:categories])
    render :json => {}
  end
  controller do
    def index
      if params[:parser]
        url=  params[:parser]['URL']
        doc = Nokogiri::HTML(open(url))
         @img=''
         doc.xpath("//img").each do |link|
         @img<<link['src']
         @img<<','
         end
        url= URI.parse url
        @categories = Category.all
        @url = url.scheme+"://"+url.host
      end
      render :layout => 'active_admin'
    end
  end
end