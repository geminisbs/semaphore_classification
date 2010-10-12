module Semaphore

  class Client
    
    LANGUAGES = { :english => "en", :english_marathon_stemmer => "en1", :english_morphological_stemmer => "en2", :english_morph_and_derivational_stemmer => "en3", 
                  :french => "fr", :italian => "it", :german => "de", :spanish => "es", :dutch => "nl", :portuguese => "pt", :danish => "da", :norwegian => "no", 
                  :swedish => "sv", :arabic => "ar" 
                  }
                  
    CLUSTERING_TYPES = { :all => "ALL", :average => "AVERAGE_INCLUDING_EMPTY", :average_scored_only => "AVERAGE", :common_scored_only => "COMMON", 
                         :common => "COMMON_INCLUDING_EMPTY", :rms_scored_only => "RMS", :rms => "RMS_INCLUDING_EMPTY", :none => "NONE"
                         }
    
    @@default_options = { :title => "", :alternate_body => "", :debug => false, :clustering_type => CLUSTERING_TYPES[:rms_scored_only], :clustering_threshold => 48,
                          :threshold => 48, :language => LANGUAGES[:english_marathon_stemmer], :generated_keys => true, :min_avg_article_page_size => 1.0, 
                          :character_cutoff => 500000, :document_score_limit => 0, :article_mode => :single
                          }
    
    TERM_QUERY = 'select.exe?TBDB=disp_taxonomy&TEMPLATE=service.xml&SERVICE=browse&ID='
    
    @@connection = nil
    @@decode_term_ids = nil

    class << self
      
      def set_realm(realm, proxy=nil)
        @@connection = Connection.new(realm, proxy)
      end
      
      def decode_term_ids=(value)
        raise RealmNotSpecified if @@connection.nil?
        @@decode_term_ids = value
        @@connection.decode_term_ids = @@decode_term_ids
      end
      
      def decode_term_ids
        @@decode_term_ids
      end

      def classify(*args)
        options = extract_options!(args)
        raise InsufficientArgs if options[:alternate_body].nil? && options[:document_uri].nil?
        
        result = post @@default_options.merge(options)
      end
      
      def decode_term_id(term_id)
        raise RealmNotSpecified if @@connection.nil?
        begin
          raw_host = decode_host(@@connection.realm)
          path = [raw_host, 'cgi-bin', "#{TERM_QUERY}#{term_id}"].join('/')
          term_doc = Nokogiri::XML.parse(open(path))
        rescue
          raise SemaphoreError
        end
        term_doc.xpath('//BROWSE_TERM/TERM/NAME').inner_text
      end
      
    private
    
      def post(data)
        raise RealmNotSpecified if @@connection.nil?
        @@connection.post data
      end
      
      def decode_host(realm)
        realm.split('/').delete_if {|i| i == 'index.html' }.join('/').gsub(':5058', '')
      end
    
      def extract_options!(args)
        if args.last.is_a?(Hash)
          return args.pop
        else
          return {}
        end
      end

    end

  end

end
