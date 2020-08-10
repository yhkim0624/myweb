<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="comments" style="font-size:14px;">
    <c:forEach var="reply" items="${ not empty replies ? replies : comments }">
        <div class="comment-container" data-no="${ reply.commentNo }" style="margin-left:${ reply.replyDepth * 20}px;">
            <div class="comment-info" style="background-color:lightgrey;height:40px;align-items:center;">
                <div style="padding-top:10px;">
                    <div style="float:left">
                        <span>&nbsp;${ reply.replier } 님</span>
                    </div>
                    <div style="float:right;text-align:right">
                        <span style="text-align:right">${ reply.replyDate }&nbsp;&nbsp;</span>
                        <c:if test="${ not reply.replyDeleted }">
                            <c:if test="${ loginuser.memberId == reply.replier }">
                                <form class="modify-form" style="float:right">
                                    <input type="hidden" id="commentNo" name="commentNo" value="${ reply.commentNo }">
                                    <input type="hidden" name="boardNo" value="${ aBoard.boardNo }">
                                    <input type="button" class="button delete" value="삭제" style="height:25px">
                                    <span>&nbsp;</span>
                                </form>
                                <input type="button" data-rno="${ reply.commentNo }" class="button modify" value="수정"
                                    style="height:25px">
                                <span>&nbsp;</span>
                            </c:if>
                            <input type="button" data-rno="${ reply.commentNo }" class="button re-reply" value="댓글"
                                style="height:25px">
                        </c:if>
                        <span>&nbsp;</span>
                    </div>
                </div>
            </div>

            <c:choose>
                <c:when test="${ not reply.replyDeleted }">
                    <div class="comment-content" style="min-height:50px;padding-top:5px">
                        <span data-selector="${ reply.commentNo }" style="padding-left:5px">${ reply.reply }</span>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="comment-content" style="min-height:50px;padding-top:5px">
                        <span style="padding-left:5px">[삭제된 댓글입니다.]</span>
                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </c:forEach>
</div>