import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ft_fndr_app/components/result_card_model.dart';
import 'package:ft_fndr_app/flutter_flow/flutter_flow_model.dart';
import 'package:ft_fndr_app/flutter_flow/flutter_flow_theme.dart';
import 'package:ft_fndr_app/flutter_flow/flutter_flow_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ResultCardWidget extends StatefulWidget {
  const ResultCardWidget({
    super.key,
    this.imgUrl,
    this.title,
    this.url,
    this.type,
  });

  final String? imgUrl;
  final String? title;
  final String? url;
  final String? type;

  @override
  State<ResultCardWidget> createState() => _ResultCardWidgetState();
}

class _ResultCardWidgetState extends State<ResultCardWidget> {
  late ResultCardModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Future<void> _openUrl() async {
    final url = widget.url;
    if (url == null || url.isEmpty) return;

    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: theme.designToken.spacing.md),
      child: GestureDetector(
        onTap: _openUrl, // whole card clickable
        child: Container(
          decoration: BoxDecoration(
            color: theme.secondaryBackground,
            borderRadius: BorderRadius.circular(theme.designToken.radius.lg),
            border: Border.all(color: theme.divider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 IMAGE (prominent)
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(theme.designToken.radius.lg),
                ),
                child: SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: widget.imgUrl != null && widget.imgUrl!.isNotEmpty
                      ? CachedNetworkImage(
                    imageUrl: widget.imgUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => Container(
                      color: Colors.grey[200],
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  )
                      : Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  ),
                ),
              ),

              // 🔹 CONTENT
              Padding(
                padding: EdgeInsets.all(theme.designToken.spacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      valueOrDefault(widget.title, 'jumia.com.gh'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.titleMedium.override(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    GestureDetector(
                      onTap: _openUrl,
                      child: Text(
                        valueOrDefault(widget.url, ''),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.bodySmall.override(
                          color: theme.primary, // clickable look
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),

                    Text(
                      valueOrDefault(widget.type, 'Web page'),
                      style: theme.bodyMedium,
                    ),
                  ].divide(SizedBox(height: theme.designToken.spacing.xs)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
