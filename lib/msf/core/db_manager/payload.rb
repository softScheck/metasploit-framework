module Msf::DBManager::Payload

  def create_payload(opts)
    Mdm::Payload.create(opts)
  end

  def get_payload(opts)
    if opts.kind_of? Mdm::Payload
      return opts
    else
      uuid = opts[:uuid] || return
    end
    ::ActiveRecord::Base.connection_pool.with_connection do
      return Mdm::Payload.find_by(uuid: uuid)
    end
  end

  def find_or_create_payload(opts)
    payload = get_payload(opts.clone)
    return payload unless payload.nil?

    create_payload(opts)
  end

  def update_payload(opts)
    ::ActiveRecord::Base.connection_pool.with_connection do
      wspace = Msf::Util::DBManager.process_opts_workspace(opts, framework, false)
      opts[:workspace] = wspace if wspace

      id = opts.delete(:id)
      Mdm::Payload.update(id, opts)
    end
  end

  def delete_payload(opts)
    'MOCK: Payload deleted!'
  end

end
