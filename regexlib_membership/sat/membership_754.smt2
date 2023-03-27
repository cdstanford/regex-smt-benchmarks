;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http(s?)://|[a-zA-Z0-9\-]+\.)[a-zA-Z0-9/~\-]+\.[a-zA-Z0-9/~\-_,&\?\.;]+[^\.,\s<]
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00C3w\x1D\u00C0CY.-.?#KNg\u00A1"
(define-fun Witness1 () String (str.++ "\u{c3}" (str.++ "w" (str.++ "\u{1d}" (str.++ "\u{c0}" (str.++ "C" (str.++ "Y" (str.++ "." (str.++ "-" (str.++ "." (str.++ "?" (str.++ "#" (str.++ "K" (str.++ "N" (str.++ "g" (str.++ "\u{a1}" ""))))))))))))))))
;witness2: "http://8.&,\u00CE\u0087\u00E1\u00B7c"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "8" (str.++ "." (str.++ "&" (str.++ "," (str.++ "\u{ce}" (str.++ "\u{87}" (str.++ "\u{e1}" (str.++ "\u{b7}" (str.++ "c" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" "")))))(re.++ (re.opt (re.range "s" "s")) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "~" "~"))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "&" "&")(re.union (re.range "," "9")(re.union (re.range ";" ";")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.union (re.range "\u{00}" "\u{08}")(re.union (re.range "\u{0e}" "\u{1f}")(re.union (re.range "!" "+")(re.union (re.range "-" "-")(re.union (re.range "/" ";")(re.union (re.range "=" "\u{84}")(re.union (re.range "\u{86}" "\u{9f}") (re.range "\u{a1}" "\u{ff}"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
