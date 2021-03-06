local conf = require 'config'
local log = require 'log'

box.once('access:v1', function()
    box.schema.user.grant('guest', 'read,write,execute', 'universe')
    -- Uncomment this to create user {{__appname__}}_user
    -- box.schema.user.create('{{__appname__}}_user', { password = '{{__appname__}}_pass' })
    -- box.schema.user.grant('{{__appname__}}_user', 'read,write,execute', 'universe')
end)

local app = {
    {{__appname__}} = require '{{__appname__}}',
}

function app.init(config)
    log.info('app init')

    for k, mod in pairs(app) do
        if type(mod) == 'table' and mod.init ~= nil then
            mod.init(config)
        end
    end
end

function app.destroy()
    log.info('app destroy')

    for k, mod in pairs(app) do
        if type(mod) == 'table' and mod.destroy ~= nil then
            mod.destroy()
        end
    end
end

package.reload:register(app)
rawset(_G, 'app', app)
return app
