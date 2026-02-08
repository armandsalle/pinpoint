import * as vscode from "vscode";

export function activate(context: vscode.ExtensionContext) {
  const cmd = vscode.commands.registerCommand("pinpoint.copy", async () => {
    const editor = vscode.window.activeTextEditor;
    if (!editor) return;

    const relativePath = vscode.workspace.asRelativePath(editor.document.uri);
    const startLine = editor.selection.start.line + 1;
    const endLine = editor.selection.end.line + 1;

    const ref =
      startLine === endLine
        ? `${relativePath}#L${startLine}`
        : `${relativePath}#L${startLine}-L${endLine}`;

    await vscode.env.clipboard.writeText(ref);
    vscode.window.setStatusBarMessage(`Pinpoint: copied ${ref}`, 3000);
  });

  context.subscriptions.push(cmd);
}

export function deactivate() {}
