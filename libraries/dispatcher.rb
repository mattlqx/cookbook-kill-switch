class Chef
  module EventDispatch
    # Monkeypatch for bypassing subscriber call when we throw an exception during recipe compilation to exit
    class Dispatcher < Base
      def recipe_file_load_failed(path, exception, recipe)
        call_subscribers(:recipe_file_load_failed, path, exception, recipe) unless recipe == 'kill-switch::default'
      end
    end
  end
end
