#!/usr/bin/env python3

"""Print info about Git repositories

If the current directory is a Git repository, the status
of it is printed. If not, all directories one-level down
are checked and status information is printed for each.
"""

import argparse
import os
import re
import subprocess
from contextlib import contextmanager

_DEFAULT_LABEL = "bbrown"
_DEFAULT_BRANCH_NAMES = ["master", "main", "develop", "development", "green"]


def _pprint(text):
    if isinstance(text, str):
        print("\t%s" % text)
    elif isinstance(text, list):
        for line in text:
            print("\t\t%s" % line)


def _run_git_cmd(cmd, remove_text=None):
    output = subprocess.check_output(["git"] + cmd).decode()
    if remove_text:
        output = output.replace(remove_text, "")

    return [line.strip() for line in output.split("\n") if line]


def _get_git_status():
    return _run_git_cmd(["status", "-s"])


def _get_git_ignores():
    return _run_git_cmd(["clean", "-Xdn"], remove_text="Would remove ")


def _get_git_stashes():
    return _run_git_cmd(["stash", "list"])


def _get_git_branch_info(label):
    curr_branch = None
    local_branches = []
    labeled_branches = []
    for branch in _run_git_cmd(["branch", "-a"]):
        strip_curr_branch_marker = branch.split("* ")
        if len(strip_curr_branch_marker) == 2:
            branch = strip_curr_branch_marker[1]
            curr_branch = branch
        else:
            branch = strip_curr_branch_marker[0]

        if not branch.startswith("remotes") and branch != curr_branch:
            local_branches.append(branch)

        if label in branch:
            labeled_branches.append(branch)

    assert curr_branch, "Error: Could not find current branch."

    # Remove duplication between local/remote labeled branches
    labeled_branches_filtered = labeled_branches + []
    for branch1 in labeled_branches:
        for branch2 in labeled_branches:
            if "remotes/origin/" + branch1 == branch2:
                labeled_branches_filtered.remove(branch2)

    return curr_branch, local_branches, labeled_branches_filtered


def _get_committers(committer):
    for line in set(_run_git_cmd(["log", "--format=%an <%ae>"])):
        match = re.search(committer, line)
        if match:
            print(f"\t{line}")


def _analyze_repo(label, verbose):
    changes = _get_git_status()
    ignores = _get_git_ignores()
    stashes = _get_git_stashes()

    curr_branch, local_branches, labeled_branches = _get_git_branch_info(label)

    def _status_checker(message, output_lines):
        if output_lines:
            _pprint(message)
            if verbose:
                _pprint(output_lines)

    if curr_branch not in _DEFAULT_BRANCH_NAMES:
        if "HEAD detached at" in curr_branch:
            _pprint("In detached state.")
        else:
            _pprint("On non-default branch %s." % curr_branch)

    _status_checker(
        "%d other local branches in repo." % len(local_branches),
        local_branches,
    )

    _status_checker(
        "%d branches contain label %s." % (len(labeled_branches), label),
        labeled_branches,
    )

    _status_checker("Repo has working changes.", changes)
    _status_checker("Repo has ignored files.", ignores)
    _status_checker("Repo has stashed changes.", stashes)


@contextmanager
def _process_repo(repo):
    print(repo + ":")
    yield
    print()


@contextmanager
def _new_cwd(path):
    os.chdir(path)
    yield
    os.chdir("..")


def _is_git_repo(path):
    return os.path.isdir(path) and os.path.isdir(os.path.join(path, ".git"))


def check_repos(label, target_repo, committer, verbose):
    cwd = os.getcwd()
    if _is_git_repo(cwd):
        repo = os.path.split(cwd)[-1]
        with _process_repo(repo):
            if committer:
                _get_committers(committer)
            else:
                _analyze_repo(label, verbose)
    else:
        for repo in sorted(os.listdir(cwd)):
            if _is_git_repo(repo):
                if not target_repo or (target_repo and repo == target_repo):
                    with _process_repo(repo):
                        with _new_cwd(repo):
                            if committer:
                                _get_committers(committer)
                            else:
                                _analyze_repo(label, verbose)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        "-l",
        "--label",
        default=_DEFAULT_LABEL,
        help="Label to use when searching for branches of interest.",
    )

    parser.add_argument(
        "-r",
        "--repo",
        default=None,
        help="Get status about a specific repo one-level down.",
    )

    parser.add_argument(
        "-c",
        "--committer",
        default=None,
        help="Check if repo has commit authors matching the provided regex",
    )

    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="Print verbose output for repo state.",
    )

    args = parser.parse_args()

    try:
        check_repos(args.label, args.repo, args.committer, args.verbose)
    except KeyboardInterrupt:
        exit(0)
