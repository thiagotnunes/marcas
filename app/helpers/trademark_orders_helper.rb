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

end