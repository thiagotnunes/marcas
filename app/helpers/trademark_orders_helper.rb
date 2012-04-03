module TrademarkOrdersHelper

  def progress_for(trademark_order)
    raw <<-eos
      <div class="progress #{trademark_order.order_status.color}" style="width: 80%;">
        <div class="bar" style="width: 100%;">
          #{trademark_order.order_status.status}
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
    actions = %{<div class="form-actions">}
    actions += link_to t('buttons.back'), trademark_orders_path, :class => 'btn'
    if can? :destroy, @trademark_order
      actions += " "
      actions += link_to t('buttons.destroy'), trademark_order_path(@trademark_order), :method => 'delete', :confirm => t('messages.confirmation'), :class => 'btn btn-danger'
    end 
    actions += %{</div>}

    raw actions
  end

  def customer_actions_for(trademark_order)
    actions = %{<div id="pay_trademark_order" class="alert alert-success">}
    actions += %{<strong>}
    actions += t('trademark_orders.prepare_payment.message') 
    actions += %{</strong><br /><br />}
    actions += link_to checkout_path(@trademark_order) do 
      image_tag('pagseguro.gif') 
    end
    actions += %{<br />}
    actions += %{<br />}
    actions += %{</div>}
    actions += %{<div class="form-actions">}
    actions += link_to t('buttons.back'), trademark_orders_path, :class => 'btn'
    actions += %{</div>}

    raw actions
  end

  def view_or_pay(trademark_order)
    if trademark_order.payed?
      link_to trademark_order.name, trademark_order_path(trademark_order)
    else
      link_to trademark_order.name, checkout_path(trademark_order)
    end
  end
end
