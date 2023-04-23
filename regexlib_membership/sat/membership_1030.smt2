;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([A-Z]{1,2}[0-9][0-9A-Z]{0,1})\ ([0-9][A-Z]{2}))|(GIR\ 0AA)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "D9P 9YZ"
(define-fun Witness1 () String (str.++ "D" (str.++ "9" (str.++ "P" (str.++ " " (str.++ "9" (str.++ "Y" (str.++ "Z" ""))))))))
;witness2: "\u00C6\u00B6GIR 0AA"
(define-fun Witness2 () String (str.++ "\u{c6}" (str.++ "\u{b6}" (str.++ "G" (str.++ "I" (str.++ "R" (str.++ " " (str.++ "0" (str.++ "A" (str.++ "A" ""))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "") (re.++ (re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.range "0" "9") (re.opt (re.union (re.range "0" "9") (re.range "A" "Z")))))(re.++ (re.range " " " ") (re.++ (re.range "0" "9") ((_ re.loop 2 2) (re.range "A" "Z")))))) (re.++ (str.to_re (str.++ "G" (str.++ "I" (str.++ "R" (str.++ " " (str.++ "0" (str.++ "A" (str.++ "A" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
