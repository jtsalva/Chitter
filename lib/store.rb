require 'google/cloud/firestore'

class Store
  def self.init(project_id)
    @@firestore = Google::Cloud::Firestore.new project_id: project_id
  end

  def self.all(collection, order_by_creation: nil, &block)
    query = @@firestore.col(collection)
    unless order_by_creation.nil?
      query = query.order('created_at', direction = order_by_creation)
    end
    query.get(&block)
  end

  def self.get(collection, ref:)
    @@firestore.doc("#{collection}/#{ref}").get
  end

  def self.set(collection, ref: nil, **data)
    location = if ref.nil?
                 collection
               else
                 "#{collection}/#{ref}"
               end
    @@firestore.doc(location).set(**data)
    @@firestore.field_server_time
  end

  def self.add(collection, **data)
    doc = @@firestore.col(collection).add(**data)
    doc.document_id
  end

  def self.delete(collection, ref: nil)
    if ref.nil?
      @@firestore.col(collection).get do |doc_snapshot|
        doc_snapshot.ref.delete
      end
    else
      @@firestore.doc("#{collection}/#{ref}").delete
    end
  end

  def self.timestamp
    @@firestore.field_server_time
  end
end