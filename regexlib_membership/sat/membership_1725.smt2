;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]([\s-./\\])?)?(\(?[2-9]\d{2}\)?|[2-9]\d{3})([\s-./\\])?([0-9]{3}([\s-./\\])?[0-9]{4}|[a-zA-Z0-9]{7}|([0-9]{3}[-][a-zA-Z0-9]{4}))
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9058918\u00A09499"
(define-fun Witness1 () String (str.++ "9" (str.++ "0" (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "1" (str.++ "8" (str.++ "\u{a0}" (str.++ "9" (str.++ "4" (str.++ "9" (str.++ "9" "")))))))))))))
;witness2: "9200994 8599\u00E3"
(define-fun Witness2 () String (str.++ "9" (str.++ "2" (str.++ "0" (str.++ "0" (str.++ "9" (str.++ "9" (str.++ "4" (str.++ " " (str.++ "8" (str.++ "5" (str.++ "9" (str.++ "9" (str.++ "\u{e3}" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.++ (re.range "0" "1") (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))))))(re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "2" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9")) (re.opt (re.range ")" ")"))))) (re.++ (re.range "2" "9") ((_ re.loop 3 3) (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) (re.union (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" "/")(re.union (re.range "\u{5c}" "\u{5c}")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))) ((_ re.loop 4 4) (re.range "0" "9"))))(re.union ((_ re.loop 7 7) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))) (re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
