// 🐦 Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:flant/components/cell.dart';
import 'package:flant/components/form.dart';
import 'package:flant/flant.dart';
import 'package:flant/utils/format/validate.dart';
import '../styles/var.dart';

FlanContactEditInfo kDefaultContact = FlanContactEditInfo(
  name: '',
  tel: '',
);

/// ### ContactEdit 联系人编辑
class FlanContactEdit extends StatefulWidget {
  FlanContactEdit({
    Key? key,
    FlanContactEditInfo? contactInfo,
    this.isEdit = false,
    this.isSaving = false,
    this.isDeleting = false,
    this.showSetDefault = false,
    this.setDefaultLabel,
    this.telValidator,
    this.onSave,
    this.onDelete,
    this.onDefaultChange,
  })  : contactInfo = contactInfo ?? kDefaultContact,
        super(key: key);

  // ****************** Props ******************
  final FlanContactEditInfo contactInfo;

  /// 是否为编辑联系人
  final bool isEdit;

  /// 是否显示保存按钮加载动画
  final bool isSaving;

  /// 是否显示删除按钮加载动画
  final bool isDeleting;

  /// 是否显示默认联系人栏
  final bool showSetDefault;

  /// 默认联系人栏文案
  final String? setDefaultLabel;

  /// 手机号格式校验函数
  final FlanFieldValidator? telValidator;

  // ****************** Events ******************
  /// 点击保存按钮时触发
  final ValueChanged<FlanContactEditInfo>? onSave;

  /// 点击删除按钮时触发
  final ValueChanged<FlanContactEditInfo>? onDelete;

  /// 默认联系人变化
  final ValueChanged<bool>? onDefaultChange;

  @override
  _FlanContactEditState createState() => _FlanContactEditState();
}

class _FlanContactEditState extends State<FlanContactEdit> {
  late FlanContactEditInfo contact;
  late TextEditingController nameControlller;
  late TextEditingController telController;
  late ValueNotifier<bool> isDefault;

  GlobalKey<FlanFormState> form = GlobalKey<FlanFormState>();

  @override
  void initState() {
    contact = widget.contactInfo;
    nameControlller = TextEditingController(text: contact.name);
    telController = TextEditingController(text: contact.tel);
    isDefault = ValueNotifier<bool>(contact.isDefault);
    super.initState();
  }

  @override
  void dispose() {
    nameControlller.dispose();
    telController.dispose();
    isDefault.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FlanContactEdit oldWidget) {
    if (widget.contactInfo.isDefault != isDefault.value) {
      isDefault.value = widget.contactInfo.isDefault;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FlanForm(
          key: form,
          onSubmit: _onSave,
          children: <FlanField>[
            FlanField(
              controller: nameControlller,
              onInput: (String val) {
                setState(() => contact.name = val);
              },
              // labelWidth: ThemeVars.contactEditFieldLabelWidth,
              clearable: true,
              label: FlanS.of(context).name,
              rules: <FlanFieldRule>[
                FlanFieldRule(
                  required: true,
                  message: FlanS.of(context).nameInvalid,
                ),
              ],
              maxLength: 30,
              border: true,
              placeholder: FlanS.of(context).nameEmpty,
            ),
            FlanField(
              controller: telController,
              onInput: (String val) {
                setState(() => contact.tel = val);
              },
              labelWidth: ThemeVars.contactEditFieldLabelWidth,
              clearable: true,
              type: FlanFieldType.tel,
              label: FlanS.of(context).tel,
              rules: <FlanFieldRule>[
                FlanFieldRule(
                  validator: widget.telValidator ??
                      (dynamic value, FlanFieldRule rule) {
                        return isMobile(value.toString());
                      },
                  message: FlanS.of(context).telInvalid,
                ),
              ],
              placeholder: FlanS.of(context).telEmpty,
            ),
          ],
        ),
        _buildSetDefault(),
        _buildButtons(),
      ],
    );
  }

  void _onSave(Map<String, dynamic> _) {
    if (!widget.isSaving && widget.onSave != null) {
      widget.onSave!(contact);
    }
  }

  void _onDelete() {
    FlanDialog.confirm(
      context,
      title: FlanS.of(context).confirmDelete,
    ).then((FlanDialogAction? action) {
      if (action == FlanDialogAction.confirm) {
        widget.onDelete?.call(contact);
      }
    });
  }

  Widget _buildSwitch() {
    return FlanSwitch<bool>(
      modalValue: isDefault,
      onChange: (bool checked) {
        widget.onDefaultChange?.call(checked);

        contact.isDefault = checked;
      },
      size: 24.0,
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: ThemeVars.contactEditButtonsPadding,
      child: Column(
        children: <Widget>[
          FlanButton(
            block: true,
            round: true,
            type: FlanButtonType.danger,
            text: FlanS.of(context).save,
            loading: widget.isSaving,
            onClick: () {
              form.currentState?.submit();
            },
          ),
          const SizedBox(height: ThemeVars.contactEditButtonMarginBottom),
          if (widget.isEdit)
            FlanButton(
              block: true,
              round: true,
              text: FlanS.of(context).delete,
              loading: widget.isDeleting,
              onClick: _onDelete,
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildSetDefault() {
    if (widget.showSetDefault) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: FlanCell(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeVars.cellHorizontalPadding,
            vertical: 9.0,
          ),
          rightIconSlot: _buildSwitch(),
          title: widget.setDefaultLabel,
          center: true,
          border: false,
        ),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DiagnosticsProperty<bool>('isEdit', widget.isEdit,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isSaving', widget.isSaving,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>('isDeleting', widget.isDeleting,
        defaultValue: false));
    properties.add(DiagnosticsProperty<bool>(
        'showSetDefault', widget.showSetDefault,
        defaultValue: false));
    properties.add(
        DiagnosticsProperty<String>('setDefaultLabel', widget.setDefaultLabel));
    properties.add(DiagnosticsProperty<FlanFieldValidator>(
        'telValidator', widget.telValidator));

    super.debugFillProperties(properties);
  }
}

class FlanContactEditInfo {
  FlanContactEditInfo({
    this.tel = '',
    this.name = '',
    this.isDefault = false,
  });

  String tel;
  String name;
  bool isDefault;

  @override
  String toString() {
    return 'FlanContactEditInfo{tel=$tel,name=$name,isDefault=$isDefault}';
  }
}
