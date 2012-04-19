module TrademarkOrdersHelper

  def progress_for(trademark_order)
    raw <<-eos
      <div class="progress #{trademark_order.purchase.order_status.color}" style="width: 80%;">
        <div class="bar" style="width: 100%;">
          #{trademark_order.purchase.order_status.status}
        </div>
      </div>
    eos
  end

  def make_downloadable(attachment)
    raw <<-eos
      <a href="#{attachment.file_url}">#{attachment.file_identifier}</a>
    eos
  end

  def admin_actions_for(trademark_order)
    actions = link_to t('trademark_orders.index.update_order_status'), edit_status_path(trademark_order.purchase), :class => 'btn btn-mini', :id => "edit-#{trademark_order.name.parameterize}"
    actions += " "
    actions += link_to t('buttons.destroy'), trademark_order_path(trademark_order), :method => 'delete', :confirm => t('messages.confirmation'), :class => 'btn btn-mini btn-danger'

    raw actions
  end

  def customer_actions_for(trademark_order)
    actions = link_to t('orders.index.pay'), checkout_path(trademark_order.purchase), :class => 'btn btn-mini btn-success', :id => "pay-#{trademark_order.name.parameterize}"

    raw actions
  end

  def username_for(trademark_order)
    user = trademark_order.purchase.user
    if user.present?
      return user.username
    else
      return I18n.t("trademark_orders.index.removed_user")
    end
  end

end
