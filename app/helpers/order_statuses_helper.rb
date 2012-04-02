module OrderStatusesHelper
  def checkbox_formatted(value)
    value == 0 ? raw('<i class="icon-remove"></i>') : raw('<i class="icon-ok"></i>')
  end

  def options_for_color
    [[t('order_statuses.form.danger'), "progress-danger"], [t('order_statuses.form.warning'), "progress-warning"], [t('order_statuses.form.info'), "progress-info"], [t('order_statuses.form.success'), "progress-success"]]
  end

  def progress_bar_from(color)
    raw <<-eos
      <div class="progress #{color}" style="width: 50px;">
        <div class="bar" style="width:100%;"></div>
      </div>
    eos
  end
end
