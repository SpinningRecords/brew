# typed: strict
# frozen_string_literal: true

require "os/linux"

module OS
  module Linux
    module Cask
      module Config
        extend T::Helpers

        requires_ancestor { ::Cask::Config }

        DEFAULT_DIRS = T.let({
          vst_plugindir:        "~/.vst",
          vst3_plugindir:       "~/.vst3",
          fontdir:              "#{ENV.fetch("XDG_DATA_HOME", "~/.local/share")}/fonts",
          appdir:               nil,
          keyboard_layoutdir:   nil,
          colorpickerdir:       nil,
          prefpanedir:          nil,
          qlplugindir:          nil,
          mdimporterdir:        nil,
          servicedir:           nil,
          dictionarydir:        nil,
          screen_saverdir:      nil,
          input_methoddir:      nil,
          internet_plugindir:   nil,
          audio_unit_plugindir: nil,
        }.freeze, T::Hash[Symbol, T.nilable(String)])

        sig { returns(T::Hash[Symbol, T.untyped]) }
        def self.defaults
          {
            languages: LazyObject.new { Linux.languages },
          }.merge(DEFAULT_DIRS).freeze
        end

        sig { returns(String) }
        def fontdir
          @fontdir ||= T.let("#{ENV.fetch("XDG_DATA_HOME", "~/.local/share")}/fonts", T.nilable(String))
        end


      end
    end
  end
end

Cask::Config.prepend(OS::Linux::Cask::Config)
