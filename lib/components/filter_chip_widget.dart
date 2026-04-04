import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'filter_chip_model.dart';
export 'filter_chip_model.dart';

class FilterChipWidget extends StatefulWidget {
  const FilterChipWidget({
    super.key,
    this.selected,
    this.label,
  });

  final bool? selected;
  final String? label;

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  late FilterChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FilterChipModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.selected == false
            ? FlutterFlowTheme.of(context).secondaryBackground
            : FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.circular(
            FlutterFlowTheme.of(context).designToken.radius.full),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primary,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 8.0),
        child: Text(
          valueOrDefault<String>(
            widget.label,
            'All',
          ),
          style: TextStyle(
            color: widget.selected == false
                ? FlutterFlowTheme.of(context).secondaryText
                : FlutterFlowTheme.of(context).primaryBackground,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
