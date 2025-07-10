;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9][a-zA-Z0-9_]*(\.{0,1})?[a-zA-Z0-9\-_]+)*(\.{0,1})@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|([a-zA-Z0-9\-]+(\.([a-zA-Z]{2,10}))(\.([a-zA-Z]{2,10}))?(\.([a-zA-Z]{2,10}))?))[\s]*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ".@[897.229.749.\u00A0\u00A0\u00A0\u0085"
(define-fun Witness1 () String (str.++ "." (str.++ "@" (str.++ "[" (str.++ "8" (str.++ "9" (str.++ "7" (str.++ "." (str.++ "2" (str.++ "2" (str.++ "9" (str.++ "." (str.++ "7" (str.++ "4" (str.++ "9" (str.++ "." (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{a0}" (str.++ "\u{85}" ""))))))))))))))))))))
;witness2: "39-yR8F8A8_.-@[4.834.9."
(define-fun Witness2 () String (str.++ "3" (str.++ "9" (str.++ "-" (str.++ "y" (str.++ "R" (str.++ "8" (str.++ "F" (str.++ "8" (str.++ "A" (str.++ "8" (str.++ "_" (str.++ "." (str.++ "-" (str.++ "@" (str.++ "[" (str.++ "4" (str.++ "." (str.++ "8" (str.++ "3" (str.++ "4" (str.++ "." (str.++ "9" (str.++ "." ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.opt (re.range "." "."))) (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." "."))))))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.++ (re.range "." ".") ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
