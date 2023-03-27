;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "z2K@8aw.z9-h3.uZwdz8@9.yaNMBt.t-.@-.XaqUwg8Z@6.xUb"
(define-fun Witness1 () String (str.++ "z" (str.++ "2" (str.++ "K" (str.++ "@" (str.++ "8" (str.++ "a" (str.++ "w" (str.++ "." (str.++ "z" (str.++ "9" (str.++ "-" (str.++ "h" (str.++ "3" (str.++ "." (str.++ "u" (str.++ "Z" (str.++ "w" (str.++ "d" (str.++ "z" (str.++ "8" (str.++ "@" (str.++ "9" (str.++ "." (str.++ "y" (str.++ "a" (str.++ "N" (str.++ "M" (str.++ "B" (str.++ "t" (str.++ "." (str.++ "t" (str.++ "-" (str.++ "." (str.++ "@" (str.++ "-" (str.++ "." (str.++ "X" (str.++ "a" (str.++ "q" (str.++ "U" (str.++ "w" (str.++ "g" (str.++ "8" (str.++ "Z" (str.++ "@" (str.++ "6" (str.++ "." (str.++ "x" (str.++ "U" (str.++ "b" "")))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "-Gaf_@_.gCkTzx;-@h.QGfw"
(define-fun Witness2 () String (str.++ "-" (str.++ "G" (str.++ "a" (str.++ "f" (str.++ "_" (str.++ "@" (str.++ "_" (str.++ "." (str.++ "g" (str.++ "C" (str.++ "k" (str.++ "T" (str.++ "z" (str.++ "x" (str.++ ";" (str.++ "-" (str.++ "@" (str.++ "h" (str.++ "." (str.++ "Q" (str.++ "G" (str.++ "f" (str.++ "w" ""))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") ((_ re.loop 1 25) ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))(re.++ (re.* (re.++ (re.union (re.range "." ".") (re.range ";" ";")) (re.+ (re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "@" "@")(re.++ (re.+ (re.union (re.range "-" ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.range "." ".") ((_ re.loop 1 25) ((_ re.loop 2 5) (re.union (re.range "A" "Z") (re.range "a" "z"))))))))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
