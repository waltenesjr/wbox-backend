# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160904200606) do

  create_table "estabelecimentos", force: :cascade do |t|
    t.string   "nome"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "estabelecimentos_usuarios", id: false, force: :cascade do |t|
    t.integer "estabelecimento_id"
    t.integer "usuario_id"
    t.boolean "ic_criador"
  end

  add_index "estabelecimentos_usuarios", ["estabelecimento_id"], name: "index_estabelecimentos_usuarios_on_estabelecimento_id"
  add_index "estabelecimentos_usuarios", ["usuario_id"], name: "index_estabelecimentos_usuarios_on_usuario_id"

  create_table "notificacao_offlines", force: :cascade do |t|
    t.integer  "produto_id"
    t.integer  "usuario_id"
    t.date     "data_notificacao"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "notificacao_offlines", ["produto_id"], name: "index_notificacao_offlines_on_produto_id"
  add_index "notificacao_offlines", ["usuario_id"], name: "index_notificacao_offlines_on_usuario_id"

  create_table "parametros", force: :cascade do |t|
    t.string   "nome"
    t.string   "valor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "produtos", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.binary   "imagem"
    t.date     "data_vencimento"
    t.integer  "estabelecimento_id"
    t.string   "categoria"
    t.string   "codigo_de_barras"
    t.integer  "quantidade"
    t.decimal  "valor"
  end

  add_index "produtos", ["estabelecimento_id"], name: "index_produtos_on_estabelecimento_id"

  create_table "produtos_usuarios", id: false, force: :cascade do |t|
    t.integer "usuario_id", null: false
    t.integer "produto_id", null: false
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token"

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["app_id", "delivered", "failed", "deliver_after"], name: "index_rapns_notifications_multi"
  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi"

  create_table "tipo_notificacaos", force: :cascade do |t|
    t.integer  "qtd_dias"
    t.string   "mensagem"
    t.boolean  "ativo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "usuario_periodos", force: :cascade do |t|
    t.integer  "usuario_id"
    t.date     "inicio_periodo"
    t.date     "fim_periodo"
    t.string   "situacao"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "usuario_periodos", ["usuario_id"], name: "index_usuario_periodos_on_usuario_id"

  create_table "usuarios", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "idpush"
    t.string   "nome"
    t.string   "senha"
    t.boolean  "ausente"
    t.string   "codigoRecuperacaoSenha"
    t.string   "codigo_indicador"
    t.string   "codigo_indicacao"
    t.boolean  "categoria"
    t.boolean  "codigo_de_barras"
    t.boolean  "quantidade"
    t.boolean  "valor"
  end

end
