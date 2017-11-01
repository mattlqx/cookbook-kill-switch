class Chef
  class RunContext
    # Monkeypatch for forcing a clean exit during compilation
    class CookbookCompiler
      compile_recipes_impl = instance_method(:compile_recipes)

      define_method(:compile_recipes) do
        begin
          compile_recipes_impl.bind(self).call
        rescue SystemExit
          @events.recipe_load_complete
          raise unless Chef.node['kill_switch']['normal_exit']
        end
      end
    end
  end
end
