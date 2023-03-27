;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (:[a-z]{1}[a-z1-9\$#_]*){1,31}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "e:r9J"
(define-fun Witness1 () String (str.++ "e" (str.++ ":" (str.++ "r" (str.++ "9" (str.++ "J" ""))))))
;witness2: ":f:x:y"
(define-fun Witness2 () String (str.++ ":" (str.++ "f" (str.++ ":" (str.++ "x" (str.++ ":" (str.++ "y" "")))))))

(assert (= regexA ((_ re.loop 1 31) (re.++ (re.range ":" ":")(re.++ (re.range "a" "z") (re.* (re.union (re.range "#" "$")(re.union (re.range "1" "9")(re.union (re.range "_" "_") (re.range "a" "z"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
