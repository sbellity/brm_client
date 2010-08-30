module BrmClient
  module Event
        
    def action(type, context=nil, event_ref="")
      event "Action", { "type" => type }, context, event_ref
    end
    
    def sign_in(service_name, agent_id=nil, agent_type=nil, context=nil, event_ref="")
      session_event("start", service_name, agent_id, agent_type, context, event_ref)
    end
    
    def sign_out(service_name, agent_id=nil, agent_type=nil, context=nil, event_ref="")
      session_event("end", service_name, agent_id, agent_type, context, event_ref)
    end
    
    def sign_in_failed(service_name, agent_id=nil, agent_type=nil, context=nil, event_ref="")
      session_event("failed", service_name, agent_id, agent_type, context, event_ref)
    end
    
    def session_expired(service_name, agent_id=nil, agent_type=nil, context=nil, event_ref="")
      session_event("expired", service_name, agent_id, agent_type, context, event_ref)
    end
    
    def location(location_id=nil, location_type="url", referrer_id=nil, referrer_type="url", context=nil, event_ref="")
      data = { "location" => { "type" => location_type, "id" => location_id } }
      data["referrer"] = { "id" => referrer_id, "type" => referrer_type } if referrer_id
      event("Location", data, context, event_ref)
    end
    
    def create(resource_id, resource_type, resource_attributes=nil, context=nil, event_ref="")
      resource_event("create", resource_id, resource_type, resource_attributes || {}, context, event_ref)
    end
    
    def update(resource_id, resource_type, resource_attributes=nil, context=nil, event_ref="")
      resource_event("update", resource_id, resource_type, resource_attributes || {}, context, event_ref)
    end
    
    def delete(resource_id, resource_type, context=nil, event_ref="")
      resource_event("delete", resource_id, resource_type, {}, context, event_ref)
    end
    
    def share(destination, resource_id, resource_type, context=nil, event_ref="")
      resource = {"id" => resource_id, "type" => resource_type }
      event("Share", {"resource" => resource, "destination" => destination }, context, event_ref)
    end
    
    def message(type, recipients, msg, context=nil, event_ref="")
      data = { "message" => msg, "recipients" => recipients, "type" => type }
      event("Message", data, context, event_ref)
    end

    def connect(type, action, with_id, with_type, attributes=nil, context=nil, event_ref="")
      data = {
        "action" => action,
        "type" => type,
        "withAgent" => { "id" => with_id, "type" => with_type }
      }
      data["attributes"] = attributes if attributes;
      event("Connect", data, context, event_ref)
    end

    def transaction(type, resources, from_id, from_type, context=nil, event_ref="")
      data = {
        "type" => type,
        "resources" => resources,
        "fromAgent" => { "id" => from_id, "type" => from_type }
      }
      event("Transaction", data, context, event_ref)
    end


    def system(type, msg="", context=nil, event_ref="")
      event("System", { "type" => type, "message" => msg }, context, event_ref)
    end

    def describe(type, resource, context=nil, event_ref="")
      event("Describe", { "type" => type, "resource" => resource }, context, event_ref)
    end


    def sign_up(service, step_status="success", context=nil, event_ref="")
      register_event(service, "register", 1, step_status, true, context, event_ref)
    end

    def unsubscribe(service, context=nil, event_ref="")
      register_event(service, "unsubscribe", -1, "success", true, context, event_ref)
    end

    def session_event(type, service_name, agent_id, agent_type, context, event_ref)
      if type != "start"
        user_id = nil
        facet_id = nil
      elsif agent_id
        if agent_type == "facet"
          facet_id = agent_id
        else
          user_id = agent_id
        end
      end

      event("Session", { "type" => type, "service" => service_name }, context, event_ref)
    end


    def resource_event(type, resource_id, resource_type, attributes=nil, context=nil, event_ref="")
      resource = attributes || {}
      resource.update("id" => resource_id, "type" => resource_type)
      event "Resource", { "resource" => resource, "type" => type }, context, event_ref
    end

    def register_event(service, step_name, step_num=0, step_status="success", complete=true, context=nil, event_ref="")
      data = {
        "service" => service,
        "step" => {
          "num" => step_num,
          "name" => step_name,
          "status" => step_status
        },
        "complete" => complete
      }
      event("Register", data, context, event_ref)
    end
  end
end
