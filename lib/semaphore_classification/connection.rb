module Semaphore

  class Connection

    attr_reader :realm

    def initialize(realm, proxy=nil)
      @realm = realm
      @proxy = proxy
    end

    def post(data)
      request :post, data
    end
    
  private

    def request(method, data)
      response = send_request method, construct_document(data)

      deconstruct_document(response)
    end

    def send_request(method, data)
      RestClient.proxy = @proxy unless @proxy.nil?
      
      begin
        response = RestClient.post @realm, :XML_INPUT => data, :multipart => true
      rescue => e
        raise_errors(e.response)
      end

      response
    end
    
    def construct_document(data)
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.request(:op => "#{ data[:debug] ? 'TEST' : 'CLASSIFY' }") {
          xml.document {
            xml.title data[:title] unless data[:title].empty?
            xml.path data[:document_uri] 
            xml.body data[:alternate_body] unless data[:alternate_body].empty?
            case data[:article_mode]
              when :multi
                xml.multiarticle
              when :single
                xml.singlearticle
            end
            xml.feedback if data[:debug]
            xml.use_generated_keys if data[:generated_keys]
            xml.clustering(:type => data[:clustering_type], :threshold => data[:clustering_threshold])
            xml.language data[:language]
            xml.threshold data[:threshold]
            xml.min_average_article_pagesize data[:min_avg_article_page_size]
            xml.char_count_cutoff data[:character_cutoff]
            xml.document_score_limit data[:document_score_limit]
          }
        }
      end
      
      builder.to_xml
    end
    
    def deconstruct_document(response)
      data = Array.new
      
      if !response.body.empty?
        begin
          doc = Nokogiri::XML.parse(response)
          doc.xpath('//META').each do |node|
            data << { :term => node['value'], :key => node['key'], :score => node['score'] } if node['name'] == "Generic"
          end
        rescue
          raise DecodeError, "content: <#{response.body}>"
        end
      end
      
      data.uniq
    end

    def raise_errors(response)
      case response.code
        when 500
          raise ServerError, "Semaphore Classification Server had an internal error. #{response.description}\n\n#{response.body}"
        when 502..503
          raise Unavailable, response.description
        else
          raise SemaphoreError, response.description
      end
    end

  end

end
