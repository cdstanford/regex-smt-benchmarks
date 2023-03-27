;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([+a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,6}|[0-9]{1,3})(\]?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "+@[948.288.8.Xj"
(define-fun Witness1 () String (str.++ "+" (str.++ "@" (str.++ "[" (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "." (str.++ "2" (str.++ "8" (str.++ "8" (str.++ "." (str.++ "8" (str.++ "." (str.++ "X" (str.++ "j" ""))))))))))))))))
;witness2: "-@PZSN.-.8"
(define-fun Witness2 () String (str.++ "-" (str.++ "@" (str.++ "P" (str.++ "Z" (str.++ "S" (str.++ "N" (str.++ "." (str.++ "-" (str.++ "." (str.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "+" "+")(re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))(re.++ (re.range "@" "@")(re.++ (re.union (re.++ (re.range "[" "[")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.range "." ".")(re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." "."))))))) (re.+ (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." "."))))(re.++ (re.union ((_ re.loop 2 6) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 1 3) (re.range "0" "9")))(re.++ (re.opt (re.range "]" "]")) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
