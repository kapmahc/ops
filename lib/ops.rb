require 'ops/engine'

module Ops
  def Ops.dashboard(user)
    unless user.is_admin?
        return nil
    end
    {
        label: 'ops.home.dashboard.title',
        links: [
            {label: '111', href: 'root_path'},
            {label: '222', href: 'root_path'},
            {label: '333', href: 'site_base_path'},
        ]
    }
  end
end
