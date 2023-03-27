;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z,#/ \.\(\)\-\+\*]*[0-9]){7}[0-9a-zA-Z,#/ \.\(\)\-\+\*]*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "TZ# Cx E99Y8k1#/-72 t0z."
(define-fun Witness1 () String (str.++ "T" (str.++ "Z" (str.++ "#" (str.++ " " (str.++ "C" (str.++ "x" (str.++ " " (str.++ "E" (str.++ "9" (str.++ "9" (str.++ "Y" (str.++ "8" (str.++ "k" (str.++ "1" (str.++ "#" (str.++ "/" (str.++ "-" (str.++ "7" (str.++ "2" (str.++ " " (str.++ "t" (str.++ "0" (str.++ "z" (str.++ "." "")))))))))))))))))))))))))
;witness2: "9d99jY287 k8s"
(define-fun Witness2 () String (str.++ "9" (str.++ "d" (str.++ "9" (str.++ "9" (str.++ "j" (str.++ "Y" (str.++ "2" (str.++ "8" (str.++ "7" (str.++ " " (str.++ "k" (str.++ "8" (str.++ "s" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 7 7) (re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "/")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (re.range "0" "9")))(re.++ (re.* (re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "(" "9")(re.union (re.range "A" "Z") (re.range "a" "z")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
