require 'ops/engine'

module Ops
  def Ops.dashboard(user)
    unless user.is_admin?
        return nil
    end
    {
        label: 'ops.dashboard.title',
        links: [
            {label: 'ops.site.info.title', href: 'site_info_path'},
            {label: 'ops.site.seo.title', href: 'site_seo_path'},
            {label: 'ops.site.status.title', href: 'site_status_path'},
            {label: 'ops.site.engines.title', href: 'site_engines_path'},
            {label: 'ops.site.jobs.title', href: 'sidekiq_web_path', blank: true},
            {label: 'activerecord.models.ops/notice', href: 'notices_path'},
            {label: 'activerecord.models.ops/leave_word', href: 'leave_words_path'},
        ]
    }
  end
end
