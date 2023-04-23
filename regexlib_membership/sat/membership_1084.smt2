;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '&quot;
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00AB\'&quot;"
(define-fun Witness1 () String (str.++ "\u{ab}" (str.++ "'" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))
;witness2: "b\'&quot;"
(define-fun Witness2 () String (str.++ "b" (str.++ "'" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" "")))))))))

(assert (= regexA (str.to_re (str.++ "'" (str.++ "&" (str.++ "q" (str.++ "u" (str.++ "o" (str.++ "t" (str.++ ";" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
