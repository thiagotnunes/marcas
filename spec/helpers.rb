module Helpers
  def ignore_security
    controller.stub!(:require_login)
    controller.stub!(:authorize!).and_return(true)
    controller.stub!(:ensure_proper_protocol).and_return(:true) 
  end
end
