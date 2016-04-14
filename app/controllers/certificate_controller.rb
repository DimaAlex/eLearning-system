class CertificateController < ApplicationController
  before_action :set_certificate, only: [:show]

  def show
    respond_to do |format|
      format.html { send_file UsersCourse.find(@certificate_id).certificate, type: 'application/pdf', disposition: 'inline' }
      format.pdf { send_file UsersCourse.find(@certificate_id).certificate, type: 'application/pdf', disposition: 'inline' }
    end
  end

  def set_certificate
    @certificate_id = UsersCourse.find(params[:id])
  end

end
