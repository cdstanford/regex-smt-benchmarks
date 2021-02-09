;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z0-9][a-zA-Z0-9_]*(\.{0,1})?[a-zA-Z0-9\-_]+)*(\.{0,1})@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|([a-zA-Z0-9\-]+(\.([a-zA-Z]{2,10}))(\.([a-zA-Z]{2,10}))?(\.([a-zA-Z]{2,10}))?))[\s]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ".@[897.229.749.\u00A0\u00A0\u00A0\u0085"
(define-fun Witness1 () String (seq.++ "." (seq.++ "@" (seq.++ "[" (seq.++ "8" (seq.++ "9" (seq.++ "7" (seq.++ "." (seq.++ "2" (seq.++ "2" (seq.++ "9" (seq.++ "." (seq.++ "7" (seq.++ "4" (seq.++ "9" (seq.++ "." (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\xa0" (seq.++ "\x85" ""))))))))))))))))))))
;witness2: "39-yR8F8A8_.-@[4.834.9."
(define-fun Witness2 () String (seq.++ "3" (seq.++ "9" (seq.++ "-" (seq.++ "y" (seq.++ "R" (seq.++ "8" (seq.++ "F" (seq.++ "8" (seq.++ "A" (seq.++ "8" (seq.++ "_" (seq.++ "." (seq.++ "-" (seq.++ "@" (seq.++ "[" (seq.++ "4" (seq.++ "." (seq.++ "8" (seq.++ "3" (seq.++ "4" (seq.++ "." (seq.++ "9" (seq.++ "." ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.++ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.* (re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))(re.++ (re.opt (re.opt (re.range "." "."))) (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))(re.++ (re.opt (re.range "." "."))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." "."))))))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))(re.++ (re.++ (re.range "." ".") ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.opt (re.++ (re.range "." ".") ((_ re.loop 2 10) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
