#
# This file is part of Edgehog.
#
# Copyright 2026 SECO Mind Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0
#

defmodule Edgehog.Campaigns.Campaign.Validations.RelateToBaseImage do
  @moduledoc false
  use Ash.Resource.Validation

  require Ash.Expr

  @impl Ash.Resource.Validation
  def validate(query, _opts, _context) do
    dbg(query)
    res = case Ash.Changeset.fetch_argument(query, :base_image_id) do
      {:ok, base_image_id} ->
        Ash.Changeset.filter(query, expr(campaign_mechanism[:base_image_id] == ^base_image_id))
          |> dbg()
      :error -> query
    end
    dbg(Ash.read(res))
    res
  end
end
