module ApplicationHelper
  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  class SignedIn
    def initialize(&block)
      @block = block || lambda { |user| true }
    end

    def matches?(request)
      @request = request
      signed_in? && current_user_fulfills_additional_requirements?
    end

    private

    # @api private
    def clearance_session
      @request.env['warden']
    end

    # @api private
    def current_user
      clearance_session.user
    end

    # @api private
    def current_user_fulfills_additional_requirements?
      @block.call current_user
    end

    # @api private
    def signed_in?
      clearance_session.present? && current_user.present?
    end
  end
end
