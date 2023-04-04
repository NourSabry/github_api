import 'package:flutter/material.dart';
import 'package:github_api/helpers/local-notifications.dart';
import 'package:github_api/helpers/shared_preferences.dart';
import 'package:github_api/providers/repos_fetch.dart';
import 'package:github_api/widgets/custom_dialog.dart';
import 'package:github_api/widgets/repo_info.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubReposView extends StatefulWidget {
  const GithubReposView({super.key});

  @override
  State<GithubReposView> createState() => _GithubReposViewState();
}

class _GithubReposViewState extends State<GithubReposView> {
    ScrollController _scrollController = ScrollController();
  int count = 15;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(handleScrolling);
  }

  void handleScrolling() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      setState(() {
        count += 10;
      });
    }
  }
  Future<void> _getRepos(BuildContext context) async {
    await Provider.of<Repos>(context, listen: false).fetchRepos();
  }

  void _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      launchUrl(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  notificationSch() {
    return initializeNotification();
  }

  @override
  void didChangeDependencies() {
    notificationSch();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Square Publich Repos"),
      ),
      body: FutureBuilder(
        future: _getRepos(context),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : snapShot.hasError
                ? Container()
                : RefreshIndicator(
                    onRefresh: () {
                      removeValues();
                      return _getRepos(context);
                    },
                    child: Consumer<Repos>(builder: (ctx, reposdata, _) {
                      return Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (_, i) => Column(
                            children: [
                              ReposInfo(
                                desc: reposdata.repos[i].description ?? '',
                                ownerName: reposdata.repos[i].owner!.login!,
                                repoName: reposdata.repos[i].name!,
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialog(
                                        repoLaunch: () async {
                                          var url = Uri.parse(
                                            reposdata.repos[i].url!,
                                          );

                                          _launchUrl(url);
                                        },
                                        ownerLaunch: () async {
                                          var url = Uri.parse(
                                            reposdata.repos[i].owner!.url!,
                                          );
                                          _launchUrl(url);
                                        },
                                      );
                                    },
                                  );
                                },
                                color: reposdata.repos[i].fork == true
                                    ? const Color.fromARGB(255, 151, 201, 95)
                                    : Colors.white,
                              ),
                              const Divider(),
                            ],
                          ),
                          itemCount: reposdata.repos.length,
                        ),
                      );
                    }),
                  ),
      ),
    );
  }
}
