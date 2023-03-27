;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\x0952-979-0884"
(define-fun Witness1 () String (str.++ "\u{00}" (str.++ "9" (str.++ "5" (str.++ "2" (str.++ "-" (str.++ "9" (str.++ "7" (str.++ "9" (str.++ "-" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "4" ""))))))))))))))
;witness2: "999-255-4889\xD\u00BE:"
(define-fun Witness2 () String (str.++ "9" (str.++ "9" (str.++ "9" (str.++ "-" (str.++ "2" (str.++ "5" (str.++ "5" (str.++ "-" (str.++ "4" (str.++ "8" (str.++ "8" (str.++ "9" (str.++ "\u{0d}" (str.++ "\u{be}" (str.++ ":" ""))))))))))))))))

(assert (= regexA (re.++ (re.opt (re.union (re.++ (re.range "(" "(")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range ")" ")") (re.opt (re.range " " " "))))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.range "-" "-"))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.range "-" "-") ((_ re.loop 4 4) (re.range "0" "9")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
