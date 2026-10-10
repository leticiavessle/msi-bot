export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  // Allows to automatically instantiate createClient with right options
  // instead of createClient<Database, { PostgrestVersion: 'XX' }>(URL, KEY)
  __InternalSupabase: {
    PostgrestVersion: "14.5"
  }
  public: {
    Tables: {
      access_alerts: {
        Row: {
          conferir_identidade: boolean
          conversation_id: string | null
          created_at: string
          entrada_via: string | null
          from_retention: boolean
          id: string
          reopened: boolean
          resolved_at: string | null
          resolved_by: string | null
          status: string
          trigger_text: string
          user_id: string
        }
        Insert: {
          conferir_identidade?: boolean
          conversation_id?: string | null
          created_at?: string
          entrada_via?: string | null
          from_retention?: boolean
          id?: string
          reopened?: boolean
          resolved_at?: string | null
          resolved_by?: string | null
          status?: string
          trigger_text: string
          user_id: string
        }
        Update: {
          conferir_identidade?: boolean
          conversation_id?: string | null
          created_at?: string
          entrada_via?: string | null
          from_retention?: boolean
          id?: string
          reopened?: boolean
          resolved_at?: string | null
          resolved_by?: string | null
          status?: string
          trigger_text?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "access_alerts_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      access_sessions: {
        Row: {
          created_at: string
          device_id: string
          expires_at: string | null
          id: string
          ip: string | null
          ip_city: string | null
          ip_country: string | null
          last_seen_at: string
          revoked_at: string | null
          started_at: string
          updated_at: string
          user_agent: string | null
          user_id: string
        }
        Insert: {
          created_at?: string
          device_id: string
          expires_at?: string | null
          id?: string
          ip?: string | null
          ip_city?: string | null
          ip_country?: string | null
          last_seen_at?: string
          revoked_at?: string | null
          started_at?: string
          updated_at?: string
          user_agent?: string | null
          user_id: string
        }
        Update: {
          created_at?: string
          device_id?: string
          expires_at?: string | null
          id?: string
          ip?: string | null
          ip_city?: string | null
          ip_country?: string | null
          last_seen_at?: string
          revoked_at?: string | null
          started_at?: string
          updated_at?: string
          user_agent?: string | null
          user_id?: string
        }
        Relationships: []
      }
      ai_settings: {
        Row: {
          active: boolean
          gemini_api_key: string | null
          gemini_key_hint: string | null
          id: boolean
          last_test_at: string | null
          last_test_error: string | null
          model_chat: string | null
          model_tasks: string | null
          openai_api_key: string | null
          openai_key_hint: string | null
          provider: string | null
          temperature: number | null
          updated_at: string
          updated_by: string | null
          updated_by_name: string | null
        }
        Insert: {
          active?: boolean
          gemini_api_key?: string | null
          gemini_key_hint?: string | null
          id?: boolean
          last_test_at?: string | null
          last_test_error?: string | null
          model_chat?: string | null
          model_tasks?: string | null
          openai_api_key?: string | null
          openai_key_hint?: string | null
          provider?: string | null
          temperature?: number | null
          updated_at?: string
          updated_by?: string | null
          updated_by_name?: string | null
        }
        Update: {
          active?: boolean
          gemini_api_key?: string | null
          gemini_key_hint?: string | null
          id?: boolean
          last_test_at?: string | null
          last_test_error?: string | null
          model_chat?: string | null
          model_tasks?: string | null
          openai_api_key?: string | null
          openai_key_hint?: string | null
          provider?: string | null
          temperature?: number | null
          updated_at?: string
          updated_by?: string | null
          updated_by_name?: string | null
        }
        Relationships: []
      }
      ai_usage_log: {
        Row: {
          created_at: string
          error: string | null
          id: string
          input_tokens: number | null
          latency_ms: number | null
          model: string | null
          output_tokens: number | null
          provider: string
          use: string
        }
        Insert: {
          created_at?: string
          error?: string | null
          id?: string
          input_tokens?: number | null
          latency_ms?: number | null
          model?: string | null
          output_tokens?: number | null
          provider: string
          use: string
        }
        Update: {
          created_at?: string
          error?: string | null
          id?: string
          input_tokens?: number | null
          latency_ms?: number | null
          model?: string | null
          output_tokens?: number | null
          provider?: string
          use?: string
        }
        Relationships: []
      }
      assistant_config: {
        Row: {
          created_at: string
          key: string
          updated_at: string
          value: Json
        }
        Insert: {
          created_at?: string
          key: string
          updated_at?: string
          value: Json
        }
        Update: {
          created_at?: string
          key?: string
          updated_at?: string
          value?: Json
        }
        Relationships: []
      }
      audit_logs: {
        Row: {
          action: string
          admin_user_id: string | null
          created_at: string
          id: string
          metadata: Json
          target_email: string | null
          target_user_id: string | null
        }
        Insert: {
          action: string
          admin_user_id?: string | null
          created_at?: string
          id?: string
          metadata?: Json
          target_email?: string | null
          target_user_id?: string | null
        }
        Update: {
          action?: string
          admin_user_id?: string | null
          created_at?: string
          id?: string
          metadata?: Json
          target_email?: string | null
          target_user_id?: string | null
        }
        Relationships: []
      }
      authorized_users: {
        Row: {
          access_expires_at: string | null
          access_source: Database["public"]["Enums"]["access_source"]
          cpf: string | null
          created_at: string
          email: string
          emails_anteriores: string[]
          id: string
          last_login_at: string | null
          metadata: Json
          name: string | null
          nome_busca: string | null
          product_access: Database["public"]["Enums"]["product_type"][]
          product_origin: string | null
          role: Database["public"]["Enums"]["app_role"]
          status: Database["public"]["Enums"]["user_status"]
          telefone: string | null
          telefone_busca: string | null
          updated_at: string
        }
        Insert: {
          access_expires_at?: string | null
          access_source?: Database["public"]["Enums"]["access_source"]
          cpf?: string | null
          created_at?: string
          email: string
          emails_anteriores?: string[]
          id?: string
          last_login_at?: string | null
          metadata?: Json
          name?: string | null
          nome_busca?: never
          product_access?: Database["public"]["Enums"]["product_type"][]
          product_origin?: string | null
          role?: Database["public"]["Enums"]["app_role"]
          status?: Database["public"]["Enums"]["user_status"]
          telefone?: string | null
          telefone_busca?: never
          updated_at?: string
        }
        Update: {
          access_expires_at?: string | null
          access_source?: Database["public"]["Enums"]["access_source"]
          cpf?: string | null
          created_at?: string
          email?: string
          emails_anteriores?: string[]
          id?: string
          last_login_at?: string | null
          metadata?: Json
          name?: string | null
          nome_busca?: never
          product_access?: Database["public"]["Enums"]["product_type"][]
          product_origin?: string | null
          role?: Database["public"]["Enums"]["app_role"]
          status?: Database["public"]["Enums"]["user_status"]
          telefone?: string | null
          telefone_busca?: never
          updated_at?: string
        }
        Relationships: []
      }
      conversation_insights: {
        Row: {
          abandoned: boolean
          classified_at: string
          conversation_id: string
          created_at: string
          day: string
          id: string
          last_message_at: string | null
          needed_human: boolean
          onboarding_stage: string | null
          refund_reason: string | null
          refund_requested: boolean
          refund_retained: boolean
          repeated_question: boolean
          resolved_by_bot: boolean
          sentiment: string
          stuck: boolean
          summary: string | null
          topic: string
          user_id: string
        }
        Insert: {
          abandoned?: boolean
          classified_at?: string
          conversation_id: string
          created_at?: string
          day: string
          id?: string
          last_message_at?: string | null
          needed_human?: boolean
          onboarding_stage?: string | null
          refund_reason?: string | null
          refund_requested?: boolean
          refund_retained?: boolean
          repeated_question?: boolean
          resolved_by_bot?: boolean
          sentiment: string
          stuck?: boolean
          summary?: string | null
          topic: string
          user_id: string
        }
        Update: {
          abandoned?: boolean
          classified_at?: string
          conversation_id?: string
          created_at?: string
          day?: string
          id?: string
          last_message_at?: string | null
          needed_human?: boolean
          onboarding_stage?: string | null
          refund_reason?: string | null
          refund_requested?: boolean
          refund_retained?: boolean
          repeated_question?: boolean
          resolved_by_bot?: boolean
          sentiment?: string
          stuck?: boolean
          summary?: string | null
          topic?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "conversation_insights_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      conversations: {
        Row: {
          created_at: string
          human_takeover_at: string | null
          human_takeover_by: string | null
          human_takeover_name: string | null
          id: string
          last_message_at: string | null
          status: string
          title: string | null
          updated_at: string
          user_id: string
        }
        Insert: {
          created_at?: string
          human_takeover_at?: string | null
          human_takeover_by?: string | null
          human_takeover_name?: string | null
          id?: string
          last_message_at?: string | null
          status?: string
          title?: string | null
          updated_at?: string
          user_id: string
        }
        Update: {
          created_at?: string
          human_takeover_at?: string | null
          human_takeover_by?: string | null
          human_takeover_name?: string | null
          id?: string
          last_message_at?: string | null
          status?: string
          title?: string | null
          updated_at?: string
          user_id?: string
        }
        Relationships: []
      }
      course_chunks: {
        Row: {
          content: string
          created_at: string
          id: string
          keywords: string[]
          lesson: string | null
          level: number | null
          module: number | null
          product: string
          source_type: string | null
          source_version: string | null
          status: string
          title: string
          topic: string | null
          updated_at: string
        }
        Insert: {
          content: string
          created_at?: string
          id: string
          keywords?: string[]
          lesson?: string | null
          level?: number | null
          module?: number | null
          product?: string
          source_type?: string | null
          source_version?: string | null
          status?: string
          title: string
          topic?: string | null
          updated_at?: string
        }
        Update: {
          content?: string
          created_at?: string
          id?: string
          keywords?: string[]
          lesson?: string | null
          level?: number | null
          module?: number | null
          product?: string
          source_type?: string | null
          source_version?: string | null
          status?: string
          title?: string
          topic?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      daily_reports: {
        Row: {
          created_at: string
          dados: Json | null
          dia: string
          edicao: string
          html: string
          id: string
          updated_at: string
          whatsapp: Json | null
          whatsapp_error: string | null
          whatsapp_sent_at: string | null
          whatsapp_status: string | null
        }
        Insert: {
          created_at?: string
          dados?: Json | null
          dia: string
          edicao: string
          html: string
          id?: string
          updated_at?: string
          whatsapp?: Json | null
          whatsapp_error?: string | null
          whatsapp_sent_at?: string | null
          whatsapp_status?: string | null
        }
        Update: {
          created_at?: string
          dados?: Json | null
          dia?: string
          edicao?: string
          html?: string
          id?: string
          updated_at?: string
          whatsapp?: Json | null
          whatsapp_error?: string | null
          whatsapp_sent_at?: string | null
          whatsapp_status?: string | null
        }
        Relationships: []
      }
      identificacao_alertas: {
        Row: {
          authorized_user_id: string | null
          cpf_digitado: string | null
          created_at: string
          device_id: string | null
          email_digitado: string | null
          id: string
          ip: string | null
          nome_digitado: string | null
          observacao: string | null
          resolucao: string | null
          resolved_at: string | null
          resolved_by: string | null
          status: string
          tentativas: number
          tipo: string
          updated_at: string
          user_id: string | null
          via: string | null
          whatsapp_digitado: string | null
        }
        Insert: {
          authorized_user_id?: string | null
          cpf_digitado?: string | null
          created_at?: string
          device_id?: string | null
          email_digitado?: string | null
          id?: string
          ip?: string | null
          nome_digitado?: string | null
          observacao?: string | null
          resolucao?: string | null
          resolved_at?: string | null
          resolved_by?: string | null
          status?: string
          tentativas?: number
          tipo: string
          updated_at?: string
          user_id?: string | null
          via?: string | null
          whatsapp_digitado?: string | null
        }
        Update: {
          authorized_user_id?: string | null
          cpf_digitado?: string | null
          created_at?: string
          device_id?: string | null
          email_digitado?: string | null
          id?: string
          ip?: string | null
          nome_digitado?: string | null
          observacao?: string | null
          resolucao?: string | null
          resolved_at?: string | null
          resolved_by?: string | null
          status?: string
          tentativas?: number
          tipo?: string
          updated_at?: string
          user_id?: string | null
          via?: string | null
          whatsapp_digitado?: string | null
        }
        Relationships: []
      }
      job_tokens: {
        Row: {
          created_at: string
          name: string
          token: string
        }
        Insert: {
          created_at?: string
          name: string
          token?: string
        }
        Update: {
          created_at?: string
          name?: string
          token?: string
        }
        Relationships: []
      }
      knowledge_chunks: {
        Row: {
          approved: boolean
          base_type: Database["public"]["Enums"]["knowledge_base_type"]
          content: string
          created_at: string
          document_id: string
          embedding: string | null
          id: string
          metadata: Json
          page_number: number | null
          product: Database["public"]["Enums"]["product_type"] | null
        }
        Insert: {
          approved?: boolean
          base_type: Database["public"]["Enums"]["knowledge_base_type"]
          content: string
          created_at?: string
          document_id: string
          embedding?: string | null
          id?: string
          metadata?: Json
          page_number?: number | null
          product?: Database["public"]["Enums"]["product_type"] | null
        }
        Update: {
          approved?: boolean
          base_type?: Database["public"]["Enums"]["knowledge_base_type"]
          content?: string
          created_at?: string
          document_id?: string
          embedding?: string | null
          id?: string
          metadata?: Json
          page_number?: number | null
          product?: Database["public"]["Enums"]["product_type"] | null
        }
        Relationships: [
          {
            foreignKeyName: "knowledge_chunks_document_id_fkey"
            columns: ["document_id"]
            isOneToOne: false
            referencedRelation: "knowledge_documents"
            referencedColumns: ["id"]
          },
        ]
      }
      knowledge_documents: {
        Row: {
          approved: boolean
          base_type: Database["public"]["Enums"]["knowledge_base_type"]
          created_at: string
          id: string
          product: Database["public"]["Enums"]["product_type"] | null
          source: string | null
          status: Database["public"]["Enums"]["document_status"]
          storage_path: string | null
          title: string
          updated_at: string
          version: number
        }
        Insert: {
          approved?: boolean
          base_type: Database["public"]["Enums"]["knowledge_base_type"]
          created_at?: string
          id?: string
          product?: Database["public"]["Enums"]["product_type"] | null
          source?: string | null
          status?: Database["public"]["Enums"]["document_status"]
          storage_path?: string | null
          title: string
          updated_at?: string
          version?: number
        }
        Update: {
          approved?: boolean
          base_type?: Database["public"]["Enums"]["knowledge_base_type"]
          created_at?: string
          id?: string
          product?: Database["public"]["Enums"]["product_type"] | null
          source?: string | null
          status?: Database["public"]["Enums"]["document_status"]
          storage_path?: string | null
          title?: string
          updated_at?: string
          version?: number
        }
        Relationships: []
      }
      material_requests: {
        Row: {
          conversation_id: string | null
          created_at: string
          id: string
          query_text: string
          terms: string[]
          user_id: string
        }
        Insert: {
          conversation_id?: string | null
          created_at?: string
          id?: string
          query_text: string
          terms?: string[]
          user_id: string
        }
        Update: {
          conversation_id?: string | null
          created_at?: string
          id?: string
          query_text?: string
          terms?: string[]
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "material_requests_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      messages: {
        Row: {
          completion_tokens: number | null
          content: string
          conversation_id: string
          cost_usd: number | null
          created_at: string
          detected_intent: string | null
          diagnosis: string | null
          id: string
          metadata: Json
          model: string | null
          prompt_tokens: number | null
          recommended_action: string | null
          role: Database["public"]["Enums"]["message_role"]
          total_tokens: number | null
          user_id: string
        }
        Insert: {
          completion_tokens?: number | null
          content: string
          conversation_id: string
          cost_usd?: number | null
          created_at?: string
          detected_intent?: string | null
          diagnosis?: string | null
          id?: string
          metadata?: Json
          model?: string | null
          prompt_tokens?: number | null
          recommended_action?: string | null
          role: Database["public"]["Enums"]["message_role"]
          total_tokens?: number | null
          user_id: string
        }
        Update: {
          completion_tokens?: number | null
          content?: string
          conversation_id?: string
          cost_usd?: number | null
          created_at?: string
          detected_intent?: string | null
          diagnosis?: string | null
          id?: string
          metadata?: Json
          model?: string | null
          prompt_tokens?: number | null
          recommended_action?: string | null
          role?: Database["public"]["Enums"]["message_role"]
          total_tokens?: number | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "messages_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      monitoring_sessions: {
        Row: {
          created_at: string
          host: string
          id: string
          note: string | null
          product: Database["public"]["Enums"]["product_type"]
          session_date: string
          session_time: string
          status: string
          title: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          host?: string
          id?: string
          note?: string | null
          product?: Database["public"]["Enums"]["product_type"]
          session_date: string
          session_time?: string
          status?: string
          title?: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          host?: string
          id?: string
          note?: string | null
          product?: Database["public"]["Enums"]["product_type"]
          session_date?: string
          session_time?: string
          status?: string
          title?: string
          updated_at?: string
        }
        Relationships: []
      }
      product_access_grants: {
        Row: {
          email: string
          granted_at: string | null
          hubla_status: string | null
          hubla_status_at: string | null
          id: string
          product: Database["public"]["Enums"]["product_type"]
          source: string | null
          updated_at: string
        }
        Insert: {
          email: string
          granted_at?: string | null
          hubla_status?: string | null
          hubla_status_at?: string | null
          id?: string
          product: Database["public"]["Enums"]["product_type"]
          source?: string | null
          updated_at?: string
        }
        Update: {
          email?: string
          granted_at?: string | null
          hubla_status?: string | null
          hubla_status_at?: string | null
          id?: string
          product?: Database["public"]["Enums"]["product_type"]
          source?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      profiles: {
        Row: {
          avatar_url: string | null
          created_at: string
          email: string | null
          id: string
          name: string | null
          updated_at: string
        }
        Insert: {
          avatar_url?: string | null
          created_at?: string
          email?: string | null
          id: string
          name?: string | null
          updated_at?: string
        }
        Update: {
          avatar_url?: string | null
          created_at?: string
          email?: string | null
          id?: string
          name?: string | null
          updated_at?: string
        }
        Relationships: []
      }
      push_broadcasts: {
        Row: {
          audience: string
          audience_value: string | null
          body: string
          created_at: string
          created_by: string | null
          devices_failed: number
          devices_sent: number
          devices_targeted: number
          id: string
          title: string
          url: string | null
        }
        Insert: {
          audience: string
          audience_value?: string | null
          body: string
          created_at?: string
          created_by?: string | null
          devices_failed?: number
          devices_sent?: number
          devices_targeted?: number
          id?: string
          title: string
          url?: string | null
        }
        Update: {
          audience?: string
          audience_value?: string | null
          body?: string
          created_at?: string
          created_by?: string | null
          devices_failed?: number
          devices_sent?: number
          devices_targeted?: number
          id?: string
          title?: string
          url?: string | null
        }
        Relationships: []
      }
      push_subscriptions: {
        Row: {
          active: boolean
          auth: string
          created_at: string
          device: string | null
          endpoint: string
          id: string
          last_used_at: string | null
          p256dh: string
          user_id: string
        }
        Insert: {
          active?: boolean
          auth: string
          created_at?: string
          device?: string | null
          endpoint: string
          id?: string
          last_used_at?: string | null
          p256dh: string
          user_id: string
        }
        Update: {
          active?: boolean
          auth?: string
          created_at?: string
          device?: string | null
          endpoint?: string
          id?: string
          last_used_at?: string | null
          p256dh?: string
          user_id?: string
        }
        Relationships: []
      }
      retention_actions: {
        Row: {
          acted_at: string
          acted_by: string
          action: string
          conversation_id: string
          destination: string | null
          id: string
          reason: string | null
          reason_text: string | null
          reasons_snapshot: string[]
          undone_at: string | null
          undone_by: string | null
          user_id: string
        }
        Insert: {
          acted_at?: string
          acted_by: string
          action: string
          conversation_id: string
          destination?: string | null
          id?: string
          reason?: string | null
          reason_text?: string | null
          reasons_snapshot?: string[]
          undone_at?: string | null
          undone_by?: string | null
          user_id: string
        }
        Update: {
          acted_at?: string
          acted_by?: string
          action?: string
          conversation_id?: string
          destination?: string | null
          id?: string
          reason?: string | null
          reason_text?: string | null
          reasons_snapshot?: string[]
          undone_at?: string | null
          undone_by?: string | null
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "retention_actions_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      risk_alerts: {
        Row: {
          accept_node: string | null
          accept_origin: string | null
          accept_reclassified: boolean
          accept_text: string | null
          conversation_id: string | null
          created_at: string
          from_retention: boolean
          id: string
          reason: string | null
          resolved_at: string | null
          reviewed_by: string | null
          risk_level: Database["public"]["Enums"]["risk_level_type"]
          status: Database["public"]["Enums"]["alert_status"]
          trigger_text: string | null
          user_id: string
          whatsapp_sent_at: string | null
        }
        Insert: {
          accept_node?: string | null
          accept_origin?: string | null
          accept_reclassified?: boolean
          accept_text?: string | null
          conversation_id?: string | null
          created_at?: string
          from_retention?: boolean
          id?: string
          reason?: string | null
          resolved_at?: string | null
          reviewed_by?: string | null
          risk_level: Database["public"]["Enums"]["risk_level_type"]
          status?: Database["public"]["Enums"]["alert_status"]
          trigger_text?: string | null
          user_id: string
          whatsapp_sent_at?: string | null
        }
        Update: {
          accept_node?: string | null
          accept_origin?: string | null
          accept_reclassified?: boolean
          accept_text?: string | null
          conversation_id?: string | null
          created_at?: string
          from_retention?: boolean
          id?: string
          reason?: string | null
          resolved_at?: string | null
          reviewed_by?: string | null
          risk_level?: Database["public"]["Enums"]["risk_level_type"]
          status?: Database["public"]["Enums"]["alert_status"]
          trigger_text?: string | null
          user_id?: string
          whatsapp_sent_at?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "risk_alerts_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      sales_alerts: {
        Row: {
          conversation_id: string | null
          created_at: string
          id: string
          product: Database["public"]["Enums"]["product_type"] | null
          resolved_at: string | null
          resolved_by: string | null
          status: string
          trigger_text: string
          user_id: string
        }
        Insert: {
          conversation_id?: string | null
          created_at?: string
          id?: string
          product?: Database["public"]["Enums"]["product_type"] | null
          resolved_at?: string | null
          resolved_by?: string | null
          status?: string
          trigger_text: string
          user_id: string
        }
        Update: {
          conversation_id?: string | null
          created_at?: string
          id?: string
          product?: Database["public"]["Enums"]["product_type"] | null
          resolved_at?: string | null
          resolved_by?: string | null
          status?: string
          trigger_text?: string
          user_id?: string
        }
        Relationships: [
          {
            foreignKeyName: "sales_alerts_conversation_id_fkey"
            columns: ["conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      stage_progress_events: {
        Row: {
          created_at: string
          from_stage: number | null
          id: string
          source: string
          to_stage: number
          user_id: string
        }
        Insert: {
          created_at?: string
          from_stage?: number | null
          id?: string
          source?: string
          to_stage: number
          user_id: string
        }
        Update: {
          created_at?: string
          from_stage?: number | null
          id?: string
          source?: string
          to_stage?: number
          user_id?: string
        }
        Relationships: []
      }
      student_memory: {
        Row: {
          action_result: string | null
          applied_before: boolean | null
          attends_monitorias: boolean | null
          capcut_basic: boolean | null
          clients_count: number
          current_difficulty: string | null
          current_stage: string | null
          dissatisfaction_signals: string[]
          edit_device: string | null
          edits_finished: number | null
          ia_access_problem: boolean | null
          ia_material_found: boolean | null
          ia_module_watched: boolean | null
          ia_need: string | null
          id: string
          instagram_ready: boolean | null
          jobs_group: boolean | null
          journey_stage: number | null
          journey_status: string
          last_evolution: string | null
          last_guidance: string | null
          last_progress_at: string | null
          main_difficulties: string | null
          next_action: string | null
          portfolio_drive_created: boolean | null
          portfolio_link: string | null
          portfolio_link_tested: boolean | null
          portfolio_ready: boolean | null
          portfolio_videos_selected: boolean | null
          recommended_action: string | null
          risk_level: Database["public"]["Enums"]["risk_level_type"]
          stage_started_at: string | null
          stages_completed: number[]
          stuck_reason: string | null
          studio_account: boolean | null
          tests_completed: number
          tool_searched: string | null
          updated_at: string
          user_id: string
          vacancies_applied: number
        }
        Insert: {
          action_result?: string | null
          applied_before?: boolean | null
          attends_monitorias?: boolean | null
          capcut_basic?: boolean | null
          clients_count?: number
          current_difficulty?: string | null
          current_stage?: string | null
          dissatisfaction_signals?: string[]
          edit_device?: string | null
          edits_finished?: number | null
          ia_access_problem?: boolean | null
          ia_material_found?: boolean | null
          ia_module_watched?: boolean | null
          ia_need?: string | null
          id?: string
          instagram_ready?: boolean | null
          jobs_group?: boolean | null
          journey_stage?: number | null
          journey_status?: string
          last_evolution?: string | null
          last_guidance?: string | null
          last_progress_at?: string | null
          main_difficulties?: string | null
          next_action?: string | null
          portfolio_drive_created?: boolean | null
          portfolio_link?: string | null
          portfolio_link_tested?: boolean | null
          portfolio_ready?: boolean | null
          portfolio_videos_selected?: boolean | null
          recommended_action?: string | null
          risk_level?: Database["public"]["Enums"]["risk_level_type"]
          stage_started_at?: string | null
          stages_completed?: number[]
          stuck_reason?: string | null
          studio_account?: boolean | null
          tests_completed?: number
          tool_searched?: string | null
          updated_at?: string
          user_id: string
          vacancies_applied?: number
        }
        Update: {
          action_result?: string | null
          applied_before?: boolean | null
          attends_monitorias?: boolean | null
          capcut_basic?: boolean | null
          clients_count?: number
          current_difficulty?: string | null
          current_stage?: string | null
          dissatisfaction_signals?: string[]
          edit_device?: string | null
          edits_finished?: number | null
          ia_access_problem?: boolean | null
          ia_material_found?: boolean | null
          ia_module_watched?: boolean | null
          ia_need?: string | null
          id?: string
          instagram_ready?: boolean | null
          jobs_group?: boolean | null
          journey_stage?: number | null
          journey_status?: string
          last_evolution?: string | null
          last_guidance?: string | null
          last_progress_at?: string | null
          main_difficulties?: string | null
          next_action?: string | null
          portfolio_drive_created?: boolean | null
          portfolio_link?: string | null
          portfolio_link_tested?: boolean | null
          portfolio_ready?: boolean | null
          portfolio_videos_selected?: boolean | null
          recommended_action?: string | null
          risk_level?: Database["public"]["Enums"]["risk_level_type"]
          stage_started_at?: string | null
          stages_completed?: number[]
          stuck_reason?: string | null
          studio_account?: boolean | null
          tests_completed?: number
          tool_searched?: string | null
          updated_at?: string
          user_id?: string
          vacancies_applied?: number
        }
        Relationships: []
      }
      student_memory_facts: {
        Row: {
          category: string | null
          confidence: number
          created_at: string
          id: string
          key: string
          source_conversation_id: string | null
          updated_at: string
          user_id: string
          value: string
        }
        Insert: {
          category?: string | null
          confidence?: number
          created_at?: string
          id?: string
          key: string
          source_conversation_id?: string | null
          updated_at?: string
          user_id: string
          value: string
        }
        Update: {
          category?: string | null
          confidence?: number
          created_at?: string
          id?: string
          key?: string
          source_conversation_id?: string | null
          updated_at?: string
          user_id?: string
          value?: string
        }
        Relationships: [
          {
            foreignKeyName: "student_memory_facts_source_conversation_id_fkey"
            columns: ["source_conversation_id"]
            isOneToOne: false
            referencedRelation: "conversations"
            referencedColumns: ["id"]
          },
        ]
      }
      support_materials: {
        Row: {
          access_scope: string[]
          active: boolean
          aliases: string[]
          availability_status: string | null
          commercial_offer: boolean
          contact_type: string | null
          contact_value: string | null
          copyright_owner: string | null
          created_at: string
          created_by: string | null
          description: string | null
          distribution_authorized: boolean
          download_url: string | null
          file_name: string | null
          file_size: number | null
          folder_contents_verified: string[]
          id: string
          keywords: string[]
          last_checked_at: string | null
          lesson_ref: string | null
          lesson_title: string | null
          level: number | null
          mime_type: string | null
          module: number | null
          notes: string | null
          page_count: number | null
          price_display: string | null
          price_verified_at: string | null
          product: Database["public"]["Enums"]["product_type"] | null
          related_resource_id: string | null
          resource_type: string
          risk_notice: string | null
          send_policy: string | null
          sha256: string | null
          slug: string | null
          source_url: string | null
          status: string
          storage_path: string | null
          temporary_link: boolean
          title: string
          updated_at: string
          updated_by: string | null
          verified_at: string | null
          version: string | null
        }
        Insert: {
          access_scope?: string[]
          active?: boolean
          aliases?: string[]
          availability_status?: string | null
          commercial_offer?: boolean
          contact_type?: string | null
          contact_value?: string | null
          copyright_owner?: string | null
          created_at?: string
          created_by?: string | null
          description?: string | null
          distribution_authorized?: boolean
          download_url?: string | null
          file_name?: string | null
          file_size?: number | null
          folder_contents_verified?: string[]
          id?: string
          keywords?: string[]
          last_checked_at?: string | null
          lesson_ref?: string | null
          lesson_title?: string | null
          level?: number | null
          mime_type?: string | null
          module?: number | null
          notes?: string | null
          page_count?: number | null
          price_display?: string | null
          price_verified_at?: string | null
          product?: Database["public"]["Enums"]["product_type"] | null
          related_resource_id?: string | null
          resource_type?: string
          risk_notice?: string | null
          send_policy?: string | null
          sha256?: string | null
          slug?: string | null
          source_url?: string | null
          status?: string
          storage_path?: string | null
          temporary_link?: boolean
          title: string
          updated_at?: string
          updated_by?: string | null
          verified_at?: string | null
          version?: string | null
        }
        Update: {
          access_scope?: string[]
          active?: boolean
          aliases?: string[]
          availability_status?: string | null
          commercial_offer?: boolean
          contact_type?: string | null
          contact_value?: string | null
          copyright_owner?: string | null
          created_at?: string
          created_by?: string | null
          description?: string | null
          distribution_authorized?: boolean
          download_url?: string | null
          file_name?: string | null
          file_size?: number | null
          folder_contents_verified?: string[]
          id?: string
          keywords?: string[]
          last_checked_at?: string | null
          lesson_ref?: string | null
          lesson_title?: string | null
          level?: number | null
          mime_type?: string | null
          module?: number | null
          notes?: string | null
          page_count?: number | null
          price_display?: string | null
          price_verified_at?: string | null
          product?: Database["public"]["Enums"]["product_type"] | null
          related_resource_id?: string | null
          resource_type?: string
          risk_notice?: string | null
          send_policy?: string | null
          sha256?: string | null
          slug?: string | null
          source_url?: string | null
          status?: string
          storage_path?: string | null
          temporary_link?: boolean
          title?: string
          updated_at?: string
          updated_by?: string | null
          verified_at?: string | null
          version?: string | null
        }
        Relationships: []
      }
      tentativas_entrada: {
        Row: {
          authorized_user_id: string | null
          created_at: string
          device_id: string | null
          etapa: string
          id: string
          ip: string | null
          resultado: string
          user_id: string | null
          via: string | null
        }
        Insert: {
          authorized_user_id?: string | null
          created_at?: string
          device_id?: string | null
          etapa: string
          id?: string
          ip?: string | null
          resultado: string
          user_id?: string | null
          via?: string | null
        }
        Update: {
          authorized_user_id?: string | null
          created_at?: string
          device_id?: string | null
          etapa?: string
          id?: string
          ip?: string | null
          resultado?: string
          user_id?: string | null
          via?: string | null
        }
        Relationships: []
      }
      tool_links: {
        Row: {
          aliases: string[]
          category: string | null
          course_use: string | null
          created_at: string
          id: string
          modules: number[]
          name: string
          official_url: string | null
          status: string
          updated_at: string
          verified_at: string | null
        }
        Insert: {
          aliases?: string[]
          category?: string | null
          course_use?: string | null
          created_at?: string
          id: string
          modules?: number[]
          name: string
          official_url?: string | null
          status?: string
          updated_at?: string
          verified_at?: string | null
        }
        Update: {
          aliases?: string[]
          category?: string | null
          course_use?: string | null
          created_at?: string
          id?: string
          modules?: number[]
          name?: string
          official_url?: string | null
          status?: string
          updated_at?: string
          verified_at?: string | null
        }
        Relationships: []
      }
      usage_events: {
        Row: {
          created_at: string
          event_name: string
          id: string
          metadata: Json
          session_id: string | null
          user_id: string
        }
        Insert: {
          created_at?: string
          event_name: string
          id?: string
          metadata?: Json
          session_id?: string | null
          user_id: string
        }
        Update: {
          created_at?: string
          event_name?: string
          id?: string
          metadata?: Json
          session_id?: string | null
          user_id?: string
        }
        Relationships: []
      }
      user_products: {
        Row: {
          active: boolean
          created_at: string
          id: string
          product: Database["public"]["Enums"]["product_type"]
          user_id: string
        }
        Insert: {
          active?: boolean
          created_at?: string
          id?: string
          product: Database["public"]["Enums"]["product_type"]
          user_id: string
        }
        Update: {
          active?: boolean
          created_at?: string
          id?: string
          product?: Database["public"]["Enums"]["product_type"]
          user_id?: string
        }
        Relationships: []
      }
      user_roles: {
        Row: {
          created_at: string
          id: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Insert: {
          created_at?: string
          id?: string
          role: Database["public"]["Enums"]["app_role"]
          user_id: string
        }
        Update: {
          created_at?: string
          id?: string
          role?: Database["public"]["Enums"]["app_role"]
          user_id?: string
        }
        Relationships: []
      }
      webhook_events: {
        Row: {
          created_at: string
          event_type: string
          external_event_id: string | null
          id: string
          payload: Json
          processed: boolean
          processed_at: string | null
          processing_error: string | null
          provider: string
        }
        Insert: {
          created_at?: string
          event_type: string
          external_event_id?: string | null
          id?: string
          payload?: Json
          processed?: boolean
          processed_at?: string | null
          processing_error?: string | null
          provider: string
        }
        Update: {
          created_at?: string
          event_type?: string
          external_event_id?: string | null
          id?: string
          payload?: Json
          processed?: boolean
          processed_at?: string | null
          processing_error?: string | null
          provider?: string
        }
        Relationships: []
      }
      webhook_product_names: {
        Row: {
          created_at: string
          id: string
          last_email: string | null
          mapped_to: string | null
          name: string
          pending_count: number
          provider: string
          updated_at: string
        }
        Insert: {
          created_at?: string
          id?: string
          last_email?: string | null
          mapped_to?: string | null
          name: string
          pending_count?: number
          provider: string
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          last_email?: string | null
          mapped_to?: string | null
          name?: string
          pending_count?: number
          provider?: string
          updated_at?: string
        }
        Relationships: []
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      admin_list_conversation_people: {
        Args: { _limit?: number; _offset?: number; _term?: string }
        Returns: {
          conversation_count: number
          email: string
          first_at: string
          has_profile: boolean
          last_at: string
          name: string
          products: string[]
          total_count: number
          user_id: string
        }[]
      }
      admin_list_conversations: {
        Args: {
          _from?: string
          _include_empty?: boolean
          _limit?: number
          _offset?: number
          _term?: string
          _to?: string
          _user_id?: string
        }
        Returns: {
          created_at: string
          email: string
          has_profile: boolean
          id: string
          message_count: number
          name: string
          refund_state: Json
          status: string
          title: string
          total_count: number
          updated_at: string
          user_id: string
        }[]
      }
      admin_overview_metrics: { Args: never; Returns: Json }
      admin_usage_series: { Args: never; Returns: Json }
      ai_usage_summary: { Args: never; Returns: Json }
      has_role: {
        Args: {
          _role: Database["public"]["Enums"]["app_role"]
          _user_id: string
        }
        Returns: boolean
      }
    }
    Enums: {
      access_source:
        | "manual"
        | "import"
        | "webhook"
        | "seed"
        | "cademi"
        | "payt"
        | "lastlink"
      alert_status: "pending" | "resolved" | "ignored"
      app_role: "admin" | "student"
      document_status:
        | "pending"
        | "processing"
        | "approved"
        | "rejected"
        | "archived"
      knowledge_base_type:
        | "official_editor_dr"
        | "real_questions"
        | "official_faq"
        | "refund_risk"
        | "elite"
        | "formation"
      message_role: "user" | "assistant"
      product_type: "principal" | "top_demandas" | "cofre_pix" | "mentoria" | "vitalicia"
      risk_level_type: "low" | "medium" | "high" | "critical"
      user_status: "active" | "blocked" | "refunded" | "canceled"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type DatabaseWithoutInternals = Omit<Database, "__InternalSupabase">

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] &
        DefaultSchema["Views"])
    ? (DefaultSchema["Tables"] &
        DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends (DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never) = never,
> = DefaultSchemaTableNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
    ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends (DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never) = never,
> = DefaultSchemaEnumNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
    ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
    : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends (PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never) = never,
> = PublicCompositeTypeNameOrOptions extends {
  schema: keyof DatabaseWithoutInternals
}
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
    ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
    : never

export const Constants = {
  public: {
    Enums: {
      access_source: ["manual", "import", "webhook", "seed", "cademi", "payt", "lastlink"],
      alert_status: ["pending", "resolved", "ignored"],
      app_role: ["admin", "student"],
      document_status: [
        "pending",
        "processing",
        "approved",
        "rejected",
        "archived",
      ],
      knowledge_base_type: [
        "official_editor_dr",
        "real_questions",
        "official_faq",
        "refund_risk",
        "elite",
        "formation",
      ],
      message_role: ["user", "assistant"],
      product_type: ["principal", "top_demandas", "cofre_pix", "mentoria", "vitalicia"],
      risk_level_type: ["low", "medium", "high", "critical"],
      user_status: ["active", "blocked", "refunded", "canceled"],
    },
  },
} as const
