;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^v=spf1[ \t]+[+?~-]?(?:(?:all)|(?:ip4(?:[:][0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})?(?:/[0-9]{1,2})?)|(?:ip6(?:[:]([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})?(?:/[0-9]{1,2})?)|(?:a(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+)?(?:/[0-9]{1,2})?)|(?:mx(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+)?(?:/[0-9]{1,2})?)|(?:ptr(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:exists(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:include(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:redirect(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:exp(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|)(?:(?:[ \t]+[+?~-]?(?:(?:all)|(?:ip4(?:[:][0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})?(?:/[0-9]{1,2})?)|(?:ip6(?:[:]([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})?(?:/[0-9]{1,2})?)|(?:a(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+)?(?:/[0-9]{1,2})?)|(?:mx(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+)?(?:/[0-9]{1,2})?)|(?:ptr(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:exists(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:include(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:redirect(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|(?:exp(?:[:][A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?)+))|))*)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "v=spf1 -mx:iP.A"
(define-fun Witness1 () String (str.++ "v" (str.++ "=" (str.++ "s" (str.++ "p" (str.++ "f" (str.++ "1" (str.++ " " (str.++ "-" (str.++ "m" (str.++ "x" (str.++ ":" (str.++ "i" (str.++ "P" (str.++ "." (str.++ "A" ""))))))))))))))))
;witness2: "v=spf1\x9 a:M.xB/79 ~mx:L.A.73"
(define-fun Witness2 () String (str.++ "v" (str.++ "=" (str.++ "s" (str.++ "p" (str.++ "f" (str.++ "1" (str.++ "\u{09}" (str.++ " " (str.++ "a" (str.++ ":" (str.++ "M" (str.++ "." (str.++ "x" (str.++ "B" (str.++ "/" (str.++ "7" (str.++ "9" (str.++ " " (str.++ "~" (str.++ "m" (str.++ "x" (str.++ ":" (str.++ "L" (str.++ "." (str.++ "A" (str.++ "." (str.++ "7" (str.++ "3" "")))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "v" (str.++ "=" (str.++ "s" (str.++ "p" (str.++ "f" (str.++ "1" "")))))))(re.++ (re.+ (re.union (re.range "\u{09}" "\u{09}") (re.range " " " ")))(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "?" "?") (re.range "~" "~")))))(re.++ (re.union (str.to_re (str.++ "a" (str.++ "l" (str.++ "l" ""))))(re.union (re.++ (str.to_re (str.++ "i" (str.++ "p" (str.++ "4" ""))))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9")))))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "i" (str.++ "p" (str.++ "6" ""))))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (re.range "a" "a")(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "x" "")))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "p" (str.++ "t" (str.++ "r" (str.++ ":" "")))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "i" (str.++ "s" (str.++ "t" (str.++ "s" (str.++ ":" ""))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "i" (str.++ "n" (str.++ "c" (str.++ "l" (str.++ "u" (str.++ "d" (str.++ "e" (str.++ ":" "")))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "r" (str.++ "e" (str.++ "d" (str.++ "i" (str.++ "r" (str.++ "e" (str.++ "c" (str.++ "t" (str.++ ":" ""))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "p" (str.++ ":" "")))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))) (str.to_re "")))))))))))(re.++ (re.* (re.++ (re.+ (re.union (re.range "\u{09}" "\u{09}") (re.range " " " ")))(re.++ (re.opt (re.union (re.range "+" "+")(re.union (re.range "-" "-")(re.union (re.range "?" "?") (re.range "~" "~"))))) (re.union (str.to_re (str.++ "a" (str.++ "l" (str.++ "l" ""))))(re.union (re.++ (str.to_re (str.++ "i" (str.++ "p" (str.++ "4" ""))))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".") ((_ re.loop 1 3) (re.range "0" "9")))))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "i" (str.++ "p" (str.++ "6" ""))))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (re.range "a" "a")(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "m" (str.++ "x" "")))(re.++ (re.opt (re.++ (re.range ":" ":")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))) (re.opt (re.++ (re.range "/" "/") ((_ re.loop 1 2) (re.range "0" "9"))))))(re.union (re.++ (str.to_re (str.++ "p" (str.++ "t" (str.++ "r" (str.++ ":" "")))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "i" (str.++ "s" (str.++ "t" (str.++ "s" (str.++ ":" ""))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "i" (str.++ "n" (str.++ "c" (str.++ "l" (str.++ "u" (str.++ "d" (str.++ "e" (str.++ ":" "")))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "r" (str.++ "e" (str.++ "d" (str.++ "i" (str.++ "r" (str.++ "e" (str.++ "c" (str.++ "t" (str.++ ":" ""))))))))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))))))))(re.union (re.++ (str.to_re (str.++ "e" (str.++ "x" (str.++ "p" (str.++ ":" "")))))(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.+ (re.++ (re.range "." ".")(re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))) (re.opt (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))) (str.to_re "")))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
