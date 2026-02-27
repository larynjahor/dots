;; extends

((block_mapping
  (block_mapping_pair
    key: (flow_node) @_type_key
    value: (flow_node) @_type_value)
  (block_mapping_pair
    key: (flow_node) @_args_key
    value: (block_node
      (block_mapping
        (block_mapping_pair
          key: (flow_node) @_code_key
          value: (block_node
            (block_scalar) @injection.content))))))
  (#eq? @_type_key "type")
  (#eq? @_type_value "python")
  (#eq? @_args_key "args")
  (#eq? @_code_key "code")
  (#set! injection.language "python")
)
