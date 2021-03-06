#
# Copyright 2013 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.


class Api::V2::OrganizationsController < Api::V1::OrganizationsController

  include Api::V2::Rendering

  resource_description do
    api_version "v2"
  end

  def_param_group :organization do
    param :organization, Hash, :required => true, :action_aware => true do
      param :name, String, :desc => "name for the organization", :required => true, :action_aware => true
      param :description, String
    end
  end

  def param_rules
    {
      :create => {:organization  => [:name, :description, :label]},
      :update => {:organization  => [:name, :description]}
    }
  end

  api :POST, "/organizations", "Create an organization"
  param_group :organization
  def create
    @organization = Organization.create!(params[:organization])
    respond
  end

end
