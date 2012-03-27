module TrademarkOrdersHelper

  def progress_for(trademark_order)
    raw <<-eos
      <div class="progress progress-danger">
        <div class="bar" style="width: 20%;">
        </div>
      </div>
    eos
  end

end
