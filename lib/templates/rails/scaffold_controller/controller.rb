class <%= controller_class_name %>Controller < ApplicationController
<% unless options[:singleton] -%>
  def index
    @<%= table_name %> = <%= orm_class.all(class_name) %>
  end
<% end -%>

  def show
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def new
    @<%= file_name %> = <%= orm_class.build(class_name) %>
  end

  def edit
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

  def create
    @<%= file_name %> = <%= orm_class.build(class_name, "params[:#{file_name}]") %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.flash.create.notice')
    else
      render :new
    end
  end

  def update
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>

    if @<%= orm_instance.update_attributes("params[:#{singular_table_name}]") %>
      redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.flash.update.notice')
    else
      render :edit
    end
  end

  def destroy
    @<%= file_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    @<%= orm_instance.destroy %>

    redirect_to <%= table_name %>_url
  end
end
