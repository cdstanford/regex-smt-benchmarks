;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (http(s?)://|[a-zA-Z0-9\-]+\.)[a-zA-Z0-9/~\-]+\.[a-zA-Z0-9/~\-_,&\?\.;]+[^\.,\s<]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00C3w\x1D\u00C0CY.-.?#KNg\u00A1"
(define-fun Witness1 () String (seq.++ "\xc3" (seq.++ "w" (seq.++ "\x1d" (seq.++ "\xc0" (seq.++ "C" (seq.++ "Y" (seq.++ "." (seq.++ "-" (seq.++ "." (seq.++ "?" (seq.++ "#" (seq.++ "K" (seq.++ "N" (seq.++ "g" (seq.++ "\xa1" ""))))))))))))))))
;witness2: "http://8.&,\u00CE\u0087\u00E1\u00B7c"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "8" (seq.++ "." (seq.++ "&" (seq.++ "," (seq.++ "\xce" (seq.++ "\x87" (seq.++ "\xe1" (seq.++ "\xb7" (seq.++ "c" "")))))))))))))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.++ (re.opt (re.range "s" "s")) (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" "")))))) (re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))) (re.range "." ".")))(re.++ (re.+ (re.union (re.range "-" "-")(re.union (re.range "/" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z") (re.range "~" "~"))))))(re.++ (re.range "." ".")(re.++ (re.+ (re.union (re.range "&" "&")(re.union (re.range "," "9")(re.union (re.range ";" ";")(re.union (re.range "?" "?")(re.union (re.range "A" "Z")(re.union (re.range "_" "_")(re.union (re.range "a" "z") (re.range "~" "~"))))))))) (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "+")(re.union (re.range "-" "-")(re.union (re.range "/" ";")(re.union (re.range "=" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff"))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
