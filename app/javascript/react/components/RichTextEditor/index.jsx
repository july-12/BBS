import React, { useRef } from "react";
import ExampleTheme from "./themes/default";
import { LexicalComposer } from "@lexical/react/LexicalComposer";
import { RichTextPlugin } from "@lexical/react/LexicalRichTextPlugin";
import { ContentEditable } from "@lexical/react/LexicalContentEditable";
import { OnChangePlugin } from "@lexical/react/LexicalOnChangePlugin";
import { HistoryPlugin } from "@lexical/react/LexicalHistoryPlugin";
// import { AutoFocusPlugin } from "@lexical/react/LexicalAutoFocusPlugin";
import LexicalErrorBoundary from "@lexical/react/LexicalErrorBoundary";
// import TreeViewPlugin from "./plugins/TreeViewPlugin";
import ToolbarPlugin from "./plugins/ToolbarPlugin";
import LexicalClickableLinkPlugin from "@lexical/react/LexicalClickableLinkPlugin";
import { HeadingNode, QuoteNode } from "@lexical/rich-text";
import { TableCellNode, TableNode, TableRowNode } from "@lexical/table";
import { ListItemNode, ListNode } from "@lexical/list";
import { CodeHighlightNode, CodeNode } from "@lexical/code";
import { AutoLinkNode, LinkNode } from "@lexical/link";
import { LinkPlugin } from "@lexical/react/LexicalLinkPlugin";
import { ListPlugin } from "@lexical/react/LexicalListPlugin";
import { CheckListPlugin } from "@lexical/react/LexicalCheckListPlugin";
import { MarkdownShortcutPlugin } from "@lexical/react/LexicalMarkdownShortcutPlugin";
import { TRANSFORMERS } from "@lexical/markdown";

import ListMaxIndentLevelPlugin from "./plugins/ListMaxIndentLevelPlugin";
import CodeHighlightPlugin from "./plugins/CodeHighlightPlugin";
import AutoLinkPlugin from "./plugins/AutoLinkPlugin";
import ImagesPlugin from "./plugins/ImagePlugin";
import { ImageNode } from "./plugins/ImagePlugin/nodes/ImageNode";

function Placeholder() {
  return <div className="editor-placeholder">请输入内容...</div>;
}

export default function RichTextEditor(props) {
  // const editorStateRef = useRef();
  const editorConfig = useRef({
    // The editor theme
    theme: ExampleTheme,
    editorState: props.defaultContent,
    // Handling of errors during update
    onError(error) {
      throw error;
    },
    // Any custom nodes go here
    namespace: "MyEditor",
    editable: !props.readOnly,
    nodes: [
      HeadingNode,
      ListNode,
      ListItemNode,
      QuoteNode,
      CodeNode,
      CodeHighlightNode,
      TableNode,
      TableCellNode,
      TableRowNode,
      AutoLinkNode,
      ImageNode,
      LinkNode,
    ],
  });
  const handleClick = (e) => {
    // console.log(JSON.stringify(editorStateRef.current));
    if (e.target.tagName === "A") {
    } else {
      e.preventDefault();
    }
  };

  console.log(props);
  // if (props.readOnly) {
  //   return (
  //     <LexicalComposer initialConfig={editorConfig.current}>
  //       <div className="editor-container">
  //         <div className="editor-inner editor-inner-preview">
  //           <RichTextPlugin
  //             contentEditable={<ContentEditable className="editor-input" />}
  //             placeholder={null}
  //           />
  //           <ImagesPlugin captionsEnabled={false} />
  //         </div>
  //       </div>
  //     </LexicalComposer>
  //   );
  // }

  return (
    <div onClick={handleClick}>
      <LexicalComposer initialConfig={editorConfig.current}>
        <div className="editor-container">
          {!props.readOnly && <ToolbarPlugin />}
          <div
            className={`editor-inner  ${
              props.readOnly
                ? "editor-inner-preview"
                : "editor-container-editbox"
            }`}
          >
            <RichTextPlugin
              contentEditable={<ContentEditable className="editor-input" />}
              placeholder={<Placeholder />}
              ErrorBoundary={LexicalErrorBoundary}
            />
            <OnChangePlugin
              onChange={(editorState, editor) => {
                // console.log(editorState)
                // console.log(editor)
                // editorStateRef.current = editorState;
                props.onChange && props.onChange(editorState, editor);
              }}
            />
            <HistoryPlugin />
            {/* <AutoFocusPlugin /> */}
            {/* <TreeViewPlugin /> */}
            <CodeHighlightPlugin />
            <ListPlugin />
            <CheckListPlugin />
            <LinkPlugin />
            <ImagesPlugin captionsEnabled={false} />
            <AutoLinkPlugin />
            <LexicalClickableLinkPlugin disabled={!props.readOnly} />
            <ListMaxIndentLevelPlugin maxDepth={7} />
            <MarkdownShortcutPlugin transformers={TRANSFORMERS} />
          </div>
        </div>
      </LexicalComposer>
    </div>
  );
}
