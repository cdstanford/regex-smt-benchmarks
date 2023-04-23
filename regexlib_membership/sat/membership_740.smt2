;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((http://)|(https://))((([a-zA-Z0-9_-]*).?([a-zA-Z0-9_-]*))|(([a-zA-Z0-9_-]*).?([a-zA-Z0-9_-]*).?([a-zA-Z0-9_-]*)))/?([a-zA-Z0-9_/?%=&+#.-~]*)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "https://Y-/"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "Y" (str.++ "-" (str.++ "/" ""))))))))))))
;witness2: "http://-_zYvz\u0088Rx6/"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "-" (str.++ "_" (str.++ "z" (str.++ "Y" (str.++ "v" (str.++ "z" (str.++ "\u{88}" (str.++ "R" (str.++ "x" (str.++ "6" (str.++ "/" "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))) (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" ""))))))))))(re.++ (re.union (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))) (re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z"))))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (re.* (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "_" "_") (re.range "a" "z")))))))))))(re.++ (re.opt (re.range "/" "/"))(re.++ (re.* (re.union (re.range "#" "#")(re.union (re.range "%" "&")(re.union (re.range "+" "+") (re.range "." "~"))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
