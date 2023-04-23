;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(\+97[\s]{0,1}[\-]{0,1}[\s]{0,1}1|0)50[\s]{0,1}[\-]{0,1}[\s]{0,1}[1-9]{1}[0-9]{6}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "0508188586"
(define-fun Witness1 () String (str.++ "0" (str.++ "5" (str.++ "0" (str.++ "8" (str.++ "1" (str.++ "8" (str.++ "8" (str.++ "5" (str.++ "8" (str.++ "6" "")))))))))))
;witness2: "+97-150\u00A0-1303483"
(define-fun Witness2 () String (str.++ "+" (str.++ "9" (str.++ "7" (str.++ "-" (str.++ "1" (str.++ "5" (str.++ "0" (str.++ "\u{a0}" (str.++ "-" (str.++ "1" (str.++ "3" (str.++ "0" (str.++ "3" (str.++ "4" (str.++ "8" (str.++ "3" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "+" (str.++ "9" (str.++ "7" ""))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.range "1" "1"))))) (re.range "0" "0"))(re.++ (str.to_re (str.++ "5" (str.++ "0" "")))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.range "-" "-"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
