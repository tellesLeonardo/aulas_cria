defmodule AulasCriaWeb.Live.Aulas.Interests do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Tag
  alias AulasCriaWeb.Router.Helpers, as: Routes

  def render(assigns) do
    ~H"""
      <div class="h-screen w-full flex justify-center items-center z-50 block fixed flex-col" style="background-color: rgba(0, 0, 0, 0.5)">
        <div class="bg-white w-4/6 h-5/6 drop-shadow-xl shadow rounded-3xl px-20 py-10 flex flex-col items-center justify-between">
            <div >
              <p class="font-bold" >Seus interesses</p>
              <span class="text-2xl" > Diga-nos oque você mais gosta de estudar, ou tenha vontade de aprender. Traremos atividades e grupos voltados aos seus interesses</span>
            </div>

            <div class="grid grid-cols-4 gap-8 px-20 py-10 w-full overflow-y-auto">
              <%= for item <- @list_interest do %>
                <%= if item.id in Enum.map(@user.interests, & &1.id) do %>
                  <div phx-click="add_interest" phx-value-id={item.id} style="border-radius: 3rem;" class="cursor-pointer		 h-72 border-2 border-blue-400 w-full m-2 drop-shadow-xl flex flex-col justify-center items-center" phx-value-id={item.id}>
                    <%= img_tag(Routes.static_path(@socket, item.image), class: "ml-2 text-xl text-white w-32") %>
                    <p class="font-bold text-center"><%= item.title %></p>
                    <p class="text-center"><%= item.discription %></p>
                  </div>
                <% else %>
                  <div phx-click="add_interest" phx-value-id={item.id} style="border-radius: 3rem;" class=" cursor-pointer		 h-72 border border-gray-400 w-full m-2 drop-shadow-xl flex flex-col justify-center items-center" phx-value-id={item.id}>
                    <%= img_tag(Routes.static_path(@socket, item.image), class: "ml-2 text-xl text-white w-32") %>
                    <p class="font-bold text-center"><%= item.title %></p>
                    <p class="text-center"><%= item.discription %></p>
                  </div>
                <% end %>
              <% end %>

            </div>

            <div class="w-full">
              <%= if length(@user.interests) == 4 do %>
                <button phx-click="save-interests" class="w-full my-4 bg-blue-500  border rounded-2xl text-white text-center  py-2 px-4 drop-shadow-lg block">
                  Salvar
                </button>
              <% else %>
                <button disabled class="w-full my-4 bg-gray-100 border border-gray-400 rounded-2xl text-gray-400 text-center  py-2 px-4 drop-shadow-lg block hover:bg-gray-100">
                  escolha <%= 4 - length(@user.interests)  %>
                </button>
              <% end %>

              <button phx-click="close-interests" class="w-full my-4 bg-blue-500  border rounded-2xl text-white text-center  py-2 px-4 drop-shadow-lg block">
                Sair
              </button>
            </div>
        </div>
      </div>

    """
  end
end
