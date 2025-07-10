;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\d?\d'(\d|1[01])&quot;$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "55\'9&quot;"
(define-fun Witness1 () String (str.++ "5" (str.++ "5" (str.++ "'" (str.++ "9" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))
;witness2: "2\'10&quot;"
(define-fun Witness2 () String (str.++ "2" (str.++ "'" (str.++ "1" (str.++ "0" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.range "0" "9")(re.++ (re.range "'" "'")(re.++ (re.union (re.range "0" "9") (re.++ (re.range "1" "1") (re.range "0" "1")))(re.++ (str.to_re (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
