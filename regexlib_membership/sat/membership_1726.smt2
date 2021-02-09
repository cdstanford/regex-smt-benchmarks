;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]([\s-./\\])?)?(\(?[2-9]\d{2}\)?|[2-9]\d{3})([\s-./\\])?(\d{3}([\s-./\\])?\d{4}|[a-zA-Z0-9]{7})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "90181998302"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "0" (seq.++ "1" (seq.++ "8" (seq.++ "1" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "3" (seq.++ "0" (seq.++ "2" ""))))))))))))
;witness2: "888900\u00858568"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "0" (seq.++ "0" (seq.++ "\x85" (seq.++ "8" (seq.++ "5" (seq.++ "6" (seq.++ "8" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "0" "1") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))(re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range ")" ")"))))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) ((_ re.loop 4 4) (re.range "0" "9")))) ((_ re.loop 7 7) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
