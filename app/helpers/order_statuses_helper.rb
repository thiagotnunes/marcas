module OrderStatusesHelper
  def options_for_color
    [[t('order_statuses.form.color.danger'), "progress-danger"], [t('order_statuses.form.color.warning'), "progress-warning"], [t('order_statuses.form.color.info'), "progress-info"], [t('order_statuses.form.color.success'), "progress-success"]]
  end

  def options_for_lifecycle
    OrderStatus::LIFECYCLES.collect do |e|
      [t("order_statuses.form.lifecycle.#{e[0]}"), e[1]]
    end
  end

  def progress_bar_from(color)
    raw <<-eos
      <div class="progress #{color}" style="width: 50px;">
        <div class="bar" style="width:100%;"></div>
      </div>
    eos
  end
end
