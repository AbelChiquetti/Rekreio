use serde_json::json;

use flowy_document::parser::json::block::SerdeBlock;

#[test]
fn test_empty_data_and_children() {
  let json = json!({
      "type": "page",
  });
  let block = serde_json::from_value::<SerdeBlock>(json).unwrap();
  assert_eq!(block.ty, "page");
  assert!(block.data.is_empty());
  assert!(block.children.is_empty());
}

#[test]
fn test_data() {
  let json = json!({
    "type": "todo_list",
    "data": {
      "delta": [{ "insert": "Clique em qualquer lugar para começar a digitar." }],
      "checked": false
    }
  });
  let block = serde_json::from_value::<SerdeBlock>(json).unwrap();
  assert_eq!(block.ty, "todo_list");
  assert_eq!(block.data.len(), 2);
  assert_eq!(block.data.get("checked").unwrap(), false);
  assert_eq!(
    block.data.get("delta").unwrap().to_owned(),
    json!([{ "insert": "Clique em qualquer lugar para começar a digitar." }])
  );
  assert!(block.children.is_empty());
}

#[test]
fn test_children() {
  let json = json!({
    "type": "page",
    "children": [
      {
        "type": "heading",
        "data": {
            "delta": [{ "insert": "Boas-vindas à Rekreio!" }],
            "level": 1
        }
      },
      {
        "type": "todo_list",
        "data": {
            "delta": [{ "insert": "Boas-vindas à Rekreio!" }],
            "checked": false
        }
      }
  ]});
  let block = serde_json::from_value::<SerdeBlock>(json).unwrap();
  assert!(block.data.is_empty());
  assert_eq!(block.ty, "page");
  assert_eq!(block.children.len(), 2);
  // heading
  let heading = &block.children[0];
  assert_eq!(heading.ty, "heading");
  assert_eq!(heading.data.len(), 2);

  // todo_list
  let todo_list = &block.children[1];
  assert_eq!(todo_list.ty, "todo_list");
  assert_eq!(todo_list.data.len(), 2);
}

#[test]
fn test_nested_children() {
  let json = json!({
    "type": "page",
    "children": [
      {
        "type": "paragraph",
        "children": [
          {
            "type": "paragraph",
            "children": [
              {
                "type": "paragraph",
                "children": [
                  {
                    "type": "paragraph"
                  }
                ]
              }
            ]
          }
        ]
      }
    ]
  });
  let block = serde_json::from_value::<SerdeBlock>(json).unwrap();
  assert!(block.data.is_empty());
  assert_eq!(block.ty, "page");
  assert_eq!(
    block.children[0].children[0].children[0].children[0].ty,
    "paragraph"
  );
}
